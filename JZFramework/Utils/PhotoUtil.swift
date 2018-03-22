//
//  PhotoUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Photos

open class PhotoUtil {
    
    //MARK: - Get photos from device
    public static func showGetPhotoOptionMenu(_ vc: UIViewController){
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: AlertUtil.getActionSheetAlertStyle())
        
        let libraryButton = UIAlertAction(title: "Choose From Photos", style: .default) { _ in
            
            switch PHPhotoLibrary.authorizationStatus(){
            case .denied:
                showAccessAlertController(false)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    DispatchQueue.main.async {
                        if (newStatus == .authorized) {
                            showImagePickerView(isCamera: false, currentVC: vc)
                        } else {
                            showAccessAlertController(false)
                        }
                    }
                })
            default:
                showImagePickerView(isCamera: false, currentVC: vc)
            }
        }
        
        let cameraButton = UIAlertAction(title: "Take Photo", style: .default) { _ in
            
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
            case .denied:
                showAccessAlertController(true)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (videoGranted: Bool) -> Void in
                    
                    if (videoGranted) {
                        showImagePickerView(isCamera: true, currentVC: vc)
                    } else {
                        showAccessAlertController(true)
                    }
                })
            default:
                showImagePickerView(isCamera: true, currentVC: vc)
            }
        }
        
        optionMenu.addActions([cameraButton, libraryButton, AlertUtil.getCancelAction()])
        vc.present(optionMenu, animated: true, completion: nil)
    }
    
    
    //For UIImagePickerControllerDelegate and UINavigationControllerDelegate
    /*
    extension InboxReplyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            //camera
            if info[UIImagePickerControllerReferenceURL] == nil {
                
                func addAsAttachment() {
                    var imagePlaceholder:PHObjectPlaceholder!
                    
                    DispatchQueue.global(qos: .default).async {
                        PHPhotoLibrary.shared().performChanges({
                            
                            let request = PHAssetChangeRequest.creationRequestForAsset(from: info[UIImagePickerControllerOriginalImage]! as! UIImage)
                            imagePlaceholder = request.placeholderForCreatedAsset!
                        }, completionHandler: { (success, error) -> Void in
                            DispatchQueue.main.async {
                                if success {
                                    //image saved to photos library.
                                    BasePhotoUtility.getImageData(imageLocalId: imagePlaceholder.localIdentifier, callback: { (imageData) in
                                        if let imageData = imageData {
                                            self.viewModel.attachmentsData.value.append(imageData)
                                        } else {
                                            print("get photo data error")
                                        }
                                        picker.dismiss(animated: true, completion: nil)
                                    })
                                } else {
                                    picker.dismiss(animated: true, completion: nil)
                                    print(error!.localizedDescription)
                                }
                                picker.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                }
                
                switch PHPhotoLibrary.authorizationStatus(){
                    
                case .denied:
                    picker.dismiss(animated: false) {BasePhotoUtility.showAccessAlertController(false)}
                    return
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        
                        if (newStatus == .authorized) {
                            addAsAttachment()
                        }
                        else {
                            DispatchQueue.main.async {
                                picker.dismiss(animated: false, completion: {BasePhotoUtility.showAccessAlertController(false)})
                            }
                            return
                        }
                    })
                default:
                    break
                }
                addAsAttachment()
            }
            else{
                //photo library
                if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
                    BasePhotoUtility.getImageData(imageURL: imageURL, callback: { (imageData) in
                        if let imageData = imageData {
                            self.viewModel.attachmentsData.value.append(imageData)
                        } else {
                            print("get photo data error")
                        }
                        picker.dismiss(animated: true, completion: nil)
                    })
                }
            }
        }
    }
    */
    
    private static func showImagePickerView(isCamera: Bool, currentVC: UIViewController) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = currentVC as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = false
        imagePicker.navigationBar.isTranslucent = false
        
        if isCamera {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
            } else {
                AlertUtil.showNoFunctionAlertController(title: "No Camera", message: "Sorry, this device has no camera")
            }
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        currentVC.present(imagePicker, animated: true) {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    private static func showAccessAlertController(_ isCamera: Bool) {
        
        let alertMessage = isCamera ? "We need you turn on Camera service to access camera." : "We need you turn on Photos service to access photos."
        
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Setting", style: .default) { (action) in
            UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        }
        
        alertController.addActions([OKAction, AlertUtil.getCancelAction()])
        ViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true)
    }
    
}
