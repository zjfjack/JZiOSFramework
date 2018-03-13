//
//  PhotoUtil.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Photos

public class PhotoUtil {
    
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
    
    public static func showAccessAlertController(_ isCamera: Bool) {
        
        let alertMessage = isCamera ? "We need you turn on Camera service to access camera." : "We need you turn on Photos service to access photos."
        
        let alertController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Setting", style: .default) { (action) in
            UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        }
        
        alertController.addActions([OKAction, AlertUtil.getCancelAction()])
        ViewControllerUtil.getCurrentViewController()?.present(alertController, animated: true)
    }
    
}
