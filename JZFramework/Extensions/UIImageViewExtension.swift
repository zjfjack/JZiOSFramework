//
//  UIImageViewExtension.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Photos

extension UIImageView {
    
    func setImageFromAssetPath(assetPath: String){
        if assetPath == ""{
            return
        }
        let asset:PHFetchResult<PHAsset>
        let imageManager = PHImageManager.default()
        if assetPath.contains("asset"){
            asset = PHAsset.fetchAssets(withALAssetURLs: [URL(string: assetPath)!], options: nil)
            guard let result = asset.firstObject else{
                return
            }
            imageManager.requestImage(for: result, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: nil) { (image, dict) -> Void in
                if let image = image {
                    self.image = image
                    return
                }
                
            }
        }
        else{
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
            asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetPath], options: fetchOptions)
            guard let result = asset.firstObject else{
                return
            }
            
            let imageManager = PHImageManager.default()
            imageManager.requestImage(for: result, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: nil) { (image, dict) -> Void in
                if let image = image {
                    self.image = image
                }
            }
        }
    }
    
    
}
