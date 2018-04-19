//
//  FileService.swift
//  JZiOSFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import MobileCoreServices

open class FileService {
    
    static private let fileManager = FileManager.default
    //Example Attachments
    static let attachmentPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("Attachments")
    
    public static func createAttachmentsDirectory() {
        do {
            try fileManager.createDirectory(atPath: attachmentPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Unable to create directory \(error)")
        }
    }
    
    public static func removeAllAttachments() {
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: attachmentPath.path)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: attachmentPath.appendingPathComponent(filePath).path)
            }
        } catch {
            print("Could not clear Downloads folder: \(error)")
        }
    }
    
    public static func removeAttachment(_ name: String) {
        do {
            try fileManager.removeItem(atPath: attachmentPath.appendingPathComponent(name).path)
        } catch {
            print("Could not clear Downloads folder: \(error)")
        }
    }
    
    public static func getmimeType(_ pathExtension: String) -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
}
