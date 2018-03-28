//
//  PhotoUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Photos

open class PhotoUtil {
    
    private static var imagePickerHelper: ImagePickerHelper?
    
    //MARK: - Get photos from device
    public static func showGetPhotoOptionMenu(_ vc: UIViewController){
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: AlertUtil.getActionSheetAlertStyle())
        
        let libraryButton = UIAlertAction(title: "Choose From Photos", style: .default) { _ in
            
            switch PHPhotoLibrary.authorizationStatus(){
            case .denied:
                presentAccessAlertController(false)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    DispatchQueue.main.async {
                        if (newStatus == .authorized) {
                            presentImagePickerView(isCamera: false, currentVC: vc)
                        } else {
                            presentAccessAlertController(false)
                        }
                    }
                })
            default:
                presentImagePickerView(isCamera: false, currentVC: vc)
            }
        }
        
        let cameraButton = UIAlertAction(title: "Take Photo", style: .default) { _ in
            
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
            case .denied:
                presentAccessAlertController(true)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (videoGranted: Bool) -> Void in
                    
                    if (videoGranted) {
                        presentImagePickerView(isCamera: true, currentVC: vc)
                    } else {
                        presentAccessAlertController(true)
                    }
                })
            default:
                presentImagePickerView(isCamera: true, currentVC: vc)
            }
        }
        
        optionMenu.addActions([cameraButton, libraryButton, AlertUtil.getCancelAction()])
        vc.present(optionMenu, animated: true, completion: nil)
    }
    
    private static func presentImagePickerView(isCamera: Bool, currentVC: UIViewController) {
        
        imagePickerHelper = ImagePickerHelper()
        imagePickerHelper!.delegate = currentVC as? ImagePickerDelegate
        let imagePicker = imagePickerHelper!.picker
        imagePicker.allowsEditing = false
        imagePicker.navigationBar.isTranslucent = false
        
        if isCamera {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
            } else {
                AlertUtil.presentNoFunctionAlertController(title: "No Camera", message: "Sorry, this device has no camera")
            }
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        currentVC.present(imagePicker, animated: true) {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    public static func presentAccessAlertController(_ isCamera: Bool) {
        
        let alertMessage = isCamera ? "We need you turn on Camera service to access camera." : "We need you turn on Photos service to access photos."
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Setting", style: .default) { (action) in
            UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        }
        
        alertController.addActions([OKAction, AlertUtil.getCancelAction()])
        ViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true)
    }
    
    //AssetPath can be imageLocalId(from Camera) or imageURL(from PhotoLibrary)
    public static func getImageWithAssetPath(_ assetPath: String, callback: @escaping (UIImage?) -> Void) {
        
        guard !assetPath.isEmpty else {
            callback(nil)
            return
        }
        let assets: PHFetchResult<PHAsset>
        if assetPath.contains("asset") {
             //ImageURL
            assets = PHAsset.fetchAssets(withALAssetURLs: [URL(string: assetPath)!], options: nil)
        } else {
            //ImageLocalId
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
            assets = PHAsset.fetchAssets(withLocalIdentifiers: [assetPath], options: fetchOptions)
        }
        
        //Can get some asset information with this asset, such as FileName
        if let asset = assets.firstObject {
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil) { (image, _) -> Void in
                callback(image)
            }
        } else {
            callback(nil)
        }
    }
}

//Swift cannot extend objc protocol
//https://stackoverflow.com/questions/49441953/uiimagepickercontrollerdelegate-didfinishpickingmediawithinfo-not-called/49443008#49443008

public protocol ImagePickerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func didSelectFromCamera(with localIdentifier: String, picker: UIImagePickerController)
    func didSelectFromPhotoLibrary(with imageURL: URL, picker: UIImagePickerController)
}

fileprivate class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public weak var delegate: ImagePickerDelegate?
    public let picker = UIImagePickerController()
    
    public override init() {
        super.init()
        picker.delegate = self
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //camera
        if info[UIImagePickerControllerReferenceURL] == nil {
            
            func savePhotoAndTakeAction() {
                var imagePlaceholder:PHObjectPlaceholder!
                
                DispatchQueue.global(qos: .default).async {
                    PHPhotoLibrary.shared().performChanges({
                        let request = PHAssetChangeRequest.creationRequestForAsset(from: info[UIImagePickerControllerOriginalImage]! as! UIImage)
                        imagePlaceholder = request.placeholderForCreatedAsset!
                    }, completionHandler: { (success, error) -> Void in
                        DispatchQueue.main.async {
                            if success {
                                //image saved to photos library.
                                self.delegate?.didSelectFromCamera(with: imagePlaceholder.localIdentifier, picker: picker)
                            } else {
                                picker.dismiss(animated: true, completion: nil)
                                print(error!.localizedDescription)
                            }
                            picker.dismiss(animated: true, completion: nil)
                        }
                    })
                }
            }
            
            switch PHPhotoLibrary.authorizationStatus() {
            case .denied:
                picker.dismiss(animated: false) { PhotoUtil.presentAccessAlertController(false) }
                return
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if (newStatus == .authorized) {
                        savePhotoAndTakeAction()
                    }
                    else {
                        DispatchQueue.main.async {
                            picker.dismiss(animated: false, completion: { PhotoUtil.presentAccessAlertController(false) })
                        }
                        return
                    }
                })
            default:
                break
            }
            savePhotoAndTakeAction()
        } else {
            //photo library
            if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
                self.delegate?.didSelectFromPhotoLibrary(with: imageURL, picker: picker)
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
}



