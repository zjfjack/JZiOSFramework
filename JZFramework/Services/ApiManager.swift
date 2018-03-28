//
//  ApiManager.swift
//  JZFramework
//
//  Created by Jeff Zhang on 13/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//



/*****
 
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

open class ApiManager {
    
    static private var defaultSessionManager: Alamofire.SessionManager!
    static private var downloadSessionManager: Alamofire.SessionManager!
    static private var uploadSessionManager: Alamofire.SessionManager!
    
    //Called when user Login succeed got the accessToken(change accessToken in httpHeaders)
    public static func setupSessionManagers(accessToken: String) {
        defaultSessionManager = getDefaultAlamofireSessionManager(isTimeout: false, accessToken: accessToken)
        downloadSessionManager = getDownloadOrUploadAlamofireSessionManager(isTimeout: false, accessToken: accessToken)
        uploadSessionManager = getDownloadOrUploadAlamofireSessionManager(isTimeout: false, accessToken: accessToken)
    }
    
    //MARK: - Default Session Manager
    public static func getDefaultAlamofireSessionManager(isTimeout: Bool, accessToken: String, additionalHeader: [String:String]=[:]) -> Alamofire.SessionManager {
        
        let configuration = URLSessionConfiguration.default
        
        if isTimeout{
            configuration.timeoutIntervalForRequest = 5
            configuration.timeoutIntervalForResource = 5
        }
        
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)",
//            "X-Content-Encoding": "gzip"
        ]
        
        additionalHeader.forEach {
            configuration.httpAdditionalHeaders![$0.key] = $0.value
        }
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }
    
    public static func makeAlamofirePostRequestObject<T>(_ dataType: T.Type, url: URLConvertible, parameters: Parameters, completion: @escaping (DataResponse<BaseResponseObject<T>>) -> Void) {
        defaultSessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate().responseObject { (response: DataResponse<BaseResponseObject<T>>) in
                completion(response)
        }
    }
    
    public static func makeAlamofirePostRequestArray<T>(_ dataType: T.Type, url: URLConvertible, parameters: Parameters, completion: @escaping (DataResponse<BaseResponseArray<T>>) -> Void) {
        defaultSessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate().responseObject { (response: DataResponse<BaseResponseArray<T>>) in
                completion(response)
        }
    }
    
    public static func makeAlamofirePostRequestPrimitive<T>(_ dataType: T.Type, url: URLConvertible, parameters: Parameters, completion: @escaping (DataResponse<BaseResponsePrimitive<T>>) -> Void) {
        defaultSessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate().responseObject { (response: DataResponse<BaseResponsePrimitive<T>>) in
                completion(response)
        }
    }
    
    //MARK: - Download Session Manager
    private static func getDownloadOrUploadAlamofireSessionManager(isTimeout: Bool, accessToken: String) -> Alamofire.SessionManager {
        
        let configuration = URLSessionConfiguration.default
        
        if isTimeout{
            configuration.timeoutIntervalForRequest = 5
            configuration.timeoutIntervalForResource = 5
        }
        
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }
    
    public static func makeAlamofireDownloadRequest(url: URLConvertible, parameters: Parameters, completion: @escaping (DefaultDownloadResponse) -> Void) {
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let fileURL = FileService.attachmentPath.appendingPathComponent(response.suggestedFilename!)
            return (fileURL, [.createIntermediateDirectories])
        }
        
        downloadSessionManager.download(url, method: .get, parameters: parameters, to: destination)
            .downloadProgress { progress in
                print("Download Progess[\(parameters["id"]!)]: \(progress.fractionCompleted)")
            }.response { response in
                completion(response)
        }
    }
    public static func stopDownloadingSessions() {
        downloadSessionManager.session.getAllTasks { (tasks) in
            tasks.forEach{
                $0.cancel()
            }
        }
    }
    
    //MARK: - Upload Session Manager
    public static func makeAlamofireUploadRequest(url: URLConvertible, data: AttachmentData, completion: @escaping (Any) -> Void) {
        
        let filename = NSString(string: data.name)
        let pathPrefix = filename.deletingPathExtension
        let mimeType = FileService.getmimeType(filename.pathExtension)
        print(mimeType)
        
        uploadSessionManager.upload(multipartFormData: { multipartFormData in
            if let imageData = data as? ImageData {
                multipartFormData.append(imageData.data!, withName: pathPrefix, fileName: data.name, mimeType: mimeType)
            }
            if let fileData = data as? FileData {
                multipartFormData.append(fileData.url!, withName: pathPrefix, fileName: data.name, mimeType: mimeType)
            }}, to: url, method: .post) { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")})
                    upload.responseJSON { response in
                        completion(response)
                    }
                case .failure(let encodingError):
                    completion(encodingError)
                }
        }
    }
    
    //Example Classes
    public class AttachmentData {
        public var id: String = ""
        public var name: String = ""
        public var size: String?
        
        public func setSizeWithDecimalString(_ fileSize: Int) {
            self.size = ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .decimal)
        }
    }
    
    public class FileData: AttachmentData {
        
        public override init() {
            super.init()
        }
        
        public var url: URL?
    }
    
    public class ImageData: AttachmentData {
        
        public override init() {
            super.init()
        }
        
        public var data: Data? {
            didSet {
                image = UIImage(data: data!)
            }
        }
        public var image: UIImage?
    }
    
}
 
 
 *****/
