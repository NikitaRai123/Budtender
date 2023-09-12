//
//  HttpManager.swift
//  CullintonsCustomer
//
//  Created by Nitin Kumar on 03/04/18.
//  Copyright © 2018 Nitin Kumar. All rights reserved.
//

import UIKit

class HttpManager: HTTPURLResponse {
    static public func requestToServer(_ url: String, params: [String:Any], httpMethod: API.HttpMethod, isZipped:Bool, receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any],_ data:Data?) -> ()){
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url?.absoluteString ?? "")
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 20
        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
        print("parameters are :-  \(params)")
        if accessToken.count > 0 {
            request.setValue("\(accessToken)", forHTTPHeaderField: "Token")
            print("accessToken:- \(accessToken)")
        }
        if(httpMethod == API.HttpMethod.POST
            || httpMethod == API.HttpMethod.PUT
            || httpMethod == API.HttpMethod.DELETE) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            if isZipped == false {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Encoding: gzip")
            }
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
       
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                
                print("print response is \(response)")
                
                if(response != nil && data != nil) {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                            receivedResponse(true, json, data)
                        } else {
                            let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                            print("Error could not parse JSON: \(jsonStr ?? "")")
                            receivedResponse(false, [:], nil)
                        }
                    } catch let parseError {
                        print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("Error could not parse JSON: '\(jsonStr ?? "")'")
                        receivedResponse(false, [:], nil)
                    }
                } else {
                    receivedResponse(false, [:], nil)
                }
            }
        }
        task.resume()
    }
  

    static public func serverCall(_ url: String, params: [String:Any], httpMethod: API.HttpMethod, isZipped:Bool, receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any],_ statusCode:Int) -> ()) {
        
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(url, params: params, httpMethod: httpMethod, isZipped: isZipped) { (success, response, data) in
                if success == true {
                    if let status = response["statusCode"] as? Int {
                        switch(status) {
                        case API.statusCodes.SHOW_DATA:
                            receivedResponse(true, response, status)
                        case API.statusCodes.INVALID_ACCESS_TOKEN:
                            if let message = response["customMessage"] as? String {
                                receivedResponse(true, ["statusCode":status, "customMessage":message], status)
                            } else {
                                receivedResponse(true, ["statusCode":status, "customMessage":ERROR_MESSAGE.INVALID_ACCESS_TOKEN], status)
                            }
//                        case STATUS_CODES.SHOW_MESSAGE:
//                            if let message = response["message"] as? String {
//                                receivedResponse(false, ["statusCode":status, "message":message], status)
//                            } else {
//                                receivedResponse(false, ["statusCode":status, "message":ERROR_MESSAGE.SERVER_NOT_RESPONDING], status)
//                            }
                        default:
                            if let message = response["message"] as? String {
                                receivedResponse(false, ["statusCode":status, "message":message], status)
                            } else {
                                receivedResponse(false, ["statusCode":status, "message":ERROR_MESSAGE.SOMETHING_WRONG], status)
                            }
                        }
                    } else {
                         receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.SOMETHING_WRONG], 0)
                    }
                } else {
                    receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.SOMETHING_WRONG], 0)
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.NO_INTERNET_CONNECTION], 0)
        }
    }
    
    static public func uploadingMultipleTask(_ url:String, params: [String:Any], imgs_deleted: [String], dataArray:[PickerData]?, receivedResponse: @escaping(_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        let boundary:NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body: NSMutableData = NSMutableData()
        let paramsArray = params.keys
        for item in paramsArray {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        if imgs_deleted.count > 0 {
            imgs_deleted.forEach { img in
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\("deleted_images[]")\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("\(img)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                print("deleted images \(img)")
            }
        }
        
        
        dataArray?.enumerated().forEach({ (index, data) in
            
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            var fileName = data.fileName?.lowercased() ?? "file_name.jpg"
            print("file name is 1 \(fileName)")
            if fileName.contains(".mov") {
                fileName = fileName.replacingOccurrences(of: ".mov", with: ".mp4")
            } else
            if fileName.lowercased().contains(".heic") {
                fileName = "\(fileName.replacingOccurrences(of: ".heic", with: ".png")) \(index)"
                
            }
            
            print("file name is 2 \(fileName)")
            body.append("Content-Disposition: form-data; name=\"images[\(index)]\"; filename=\"\(index) \(fileName)\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            if data.type == .image {
                if let data1 = data.image?.jpegData(compressionQuality: 0.5) {
                    body.append(data1)
                } else
                if let data1 = data.data {
                    body.append(data1)
                }
            } else {
                if let data1 = data.data {
                    body.append(data1)
                    print("video image uploaded \(data1.count)")
                }
            }
            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            print("Multipart:- ******* \(data.fileName) ******** \(data.data?.count) ****")
            if data.type == .video {
                var fileName1 = data.fileName ?? "file_name.mp4"
                if fileName1.contains(".mov") {
                    fileName = fileName1.replacingOccurrences(of: ".mov", with: ".mp4")

                }
                print("vedio fileName is = \(fileName)")
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"image\(index)\"; filename=\"thumb_image.jpg\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                let url1 = data.url
                print("url1url1url1url1url1   ===== \(url1)")
//                let vediodata = Data(url1.utf8)
//                body.append(vediodata)
                if let data1 = data.image?.jpegData(compressionQuality: 0.5) {
                    print("image image uploaded \(data1.count)")
                    body.append(data1)
                }
                print("thumb image uploaded")
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
        })
        
//        dataArray?.enumerated().forEach({ (index, data) in
//            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Disposition: form-data; name=\"image[\(index)]\"; filename=\"\(data.fileName?.lowercased() ?? "file_name.jpg")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            if data.type == .image {
//                if let data1 = data.image?.jpegData(compressionQuality: 1.0) {
//                    body.append(data1)
//                } else
//                if let data1 = data.data {
//                    body.append(data1)
//                }
//            } else {
//                if let data1 = data.data {
//                    body.append(data1)
//                    print("video image uploaded \(data1.count)")
//                }
//            }
//            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            print("Multipart:- ******** \(data.fileName) ********* \(data.data?.count) **** ")
//            if data.type == .video {
//                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                body.append("Content-Disposition: form-data; name=\"video_thumbnail\"; filename=\"\("thumb_file_name.jpg")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                if let data1 = data.image?.jpegData(compressionQuality: 1.0) {
//                    print("image image uploaded \(data1.count)")
//                    body.append(data1)
//                }
//                print("thumb image uploaded")
//                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            }
//        })
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print("urlString   \(urlString)")
        var request   = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url)
        request.httpMethod = "POST"
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        if  let accessToken = UserDefaultsCustom.getUserData()?.auth_token,
                accessToken.count > 0 {
            print("\n\n  ************  accessToken:-  ************\n \(accessToken)\n\n")
            request.setValue(accessToken, forHTTPHeaderField: "Token")
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(data)
            print(response)
            print(error)
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        task.resume()
    }
  
    static public func uploadingMultipleTask(_ url:String, params: [String:Any], profilePhoto: PickerData?, coverPhoto: PickerData?, receivedResponse: @escaping(_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ())
    {
        let boundary:NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body:NSMutableData = NSMutableData()
        let paramsArray = params.keys
        for item in paramsArray {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        
        if let coverPhoto = coverPhoto {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"profileImage\"; filename=\"\(coverPhoto.fileName ?? "fileName.jpg")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            if let data1 = coverPhoto.image, let data = data1.jpegData(compressionQuality: 1.0) {
                print("image     data \(data.count)")
                body.append(data)
            }
            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            print("cover_photo Multipart:- ******** \(coverPhoto.fileName) ********* \(coverPhoto.data?.count) **** ")
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        if let profilePhoto = profilePhoto {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(profilePhoto.fileName ?? "fileName.jpg")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            if let data1 = profilePhoto.image, let data = data1.jpegData(compressionQuality: 1.0) {
                print("profileImage data \(data.count)")
                body.append(data)
            }
            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            print("photo Multipart:- ******** \(profilePhoto.fileName) ********* \(profilePhoto.data?.count) **** ")
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url)
        request.httpMethod = "POST"
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
        print("parameters are :-  \(params)           ,  accessToken:=== \(accessToken)")
        if accessToken.count  > 0 {
            request.setValue("\(accessToken)", forHTTPHeaderField: "Token")
            print("accessToken:- \(accessToken)")
        }
       
//        if  let accessToken = UserDefaultsCustom.getUserData()?.authToken, accessToken.count > 0 {
//            request.setValue(accessToken, forHTTPHeaderField: "Token")
//            print("accessToken ******* \(accessToken)")
//        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if  let res = response as? HTTPURLResponse{
                print(" ----------------res.statusCode -----------------  \(res.statusCode)----------------------")
//                switch res.statusCode {
//                case 200:break
//                case 400:break
//                    
//                    
//                default:
//                    break
//                }
            }
           
            
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        task.resume()
    }
    
    
    static public func uploadingMultipleTask(
        _ url: String,
        params: [String: Any],
        video: PickerData?,
        thumbnailImage: UIImage?,
        receivedResponse: @escaping (_ succeeded: Bool, _ response: [String: Any], _ data: Data?) -> ()
    ) {
        guard let url = URL(string: API.imageHost + url) else {
            receivedResponse(false, [:], nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
        request.setValue(accessToken, forHTTPHeaderField: "Token")
        
        let body = NSMutableData()

        // Add parameters to the body
        for (key, value) in params {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(value)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }

        // Handle video data
        print("Handling video data...")
        if let video = video, let videoData = video.data {
            print("Video data exists")
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"videoClip\"; filename=\"\(video.fileName ?? "video.mp4")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Type: video/mp4\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append(videoData)
            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }else{
            print("Video data is nil")
        }

        // Handle thumbnail image data
        if let thumbnailImage = thumbnailImage {
            if let thumbnailImageData = thumbnailImage.jpegData(compressionQuality: 0.5) {
                print("Thumbnail image is not nil")
                let thumbnailImageFilename = "thumbnail.jpg" // Set a valid filename for the thumbnail image
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"thumbImage\"; filename=\"\(thumbnailImageFilename)\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append(thumbnailImageData)
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            } else {
                print("thumbnailImage is nil or thumbnailImageData generation failed")
            }
        }
        



        // Close multipart form
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)

        request.httpBody = body as Data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }

            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        receivedResponse(true, json, data)
                    } else {
                        print("Error: Unable to parse JSON")
                        receivedResponse(false, [:], nil)
                    }
                } catch {
                    print("Error: \(error)")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        }
        task.resume()
    }

    
    
    
    
//    static public func uploadingMultipleTask(_ url: String, params: [String: Any], video: PickerData?, thumbnailImage: PickerData?, receivedResponse: @escaping (_ succeeded: Bool, _ response: [String: Any], _ data: Data?) -> ()) {
//        let boundary: NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
//        let body: NSMutableData = NSMutableData()
//
//        let paramsArray = params.keys
//        for item in paramsArray {
//            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//        }
////        // Add params to the body
////        for (key, value) in params {
////            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
////            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
////            body.append("\(value)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
////        }
//
//        // Handle video data
//        if let video = video {
//            print("Video data exists")
//            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Disposition: form-data; name=\"videoClip\"; filename=\"\(video.fileName ?? "video.mp4")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Type: video/mp4\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            if let data = video.data {
//                body.append(data)
//                print("Video Data Size: \(data.count) bytes")
//            }
//            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//
//            // Print statements to check if video data is being uploaded
//                    print("Video Data is being uploaded:")
//                    print("Video File Name: \(video.fileName ?? "")")
//        }else{
//            print("Video data is nil")
//        }
//
//        // Handle thumbnail image
//        if let thumbnailImage = thumbnailImage {
//            print("Thumbnail image data exists")
//            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Disposition: form-data; name=\"thumbImage\"; filename=\"\(thumbnailImage.fileName ?? "fileName.jpg")\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            if let data1 = thumbnailImage.image, let data = data1.jpegData(compressionQuality: 1.0) {
//                print("profileImage data \(data.count)")
//                body.append(data)
//            }
//            body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            print("photo Multipart:- ******** \(thumbnailImage.fileName) ********* \(thumbnailImage.data?.count) **** ")
//            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//        }else{
//            print("Thumbnail image data is nil")
//        }
//
//        // ... Rest of the code remains the same
//        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        // Create and configure URLRequest
//        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
//        // ... Set other request properties
//        print(request.url)
//        request.httpMethod = "POST"
//        request.httpBody = body as Data
//        request.timeoutInterval = 60
//        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        let accessToken = UserDefaultsCustom.getUserData()?.authToken ?? ""
//        print("parameters are :-  \(params)           ,  accessToken:=== \(accessToken)")
//        if accessToken.count  > 0 {
//            request.setValue("\(accessToken)", forHTTPHeaderField: "Token")
//            print("accessToken:- \(accessToken)")
//        }
//
////        if  let accessToken = UserDefaultsCustom.getUserData()?.authToken, accessToken.count > 0 {
////            request.setValue(accessToken, forHTTPHeaderField: "Token")
////            print("accessToken ******* \(accessToken)")
////        }
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
//            if  let res = response as? HTTPURLResponse{
//                print(" ----------------res.statusCode -----------------  \(res.statusCode)----------------------")
////                switch res.statusCode {
////                case 200:break
////                case 400:break
////
////
////                default:
////                    break
////                }
//            }
//
//
//            if(response != nil) {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
//                        receivedResponse(true, json, data)
//                    } else {
//                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                        // No error thrown, but not NSDictionary
//                        print("Error could not parse JSON: \(jsonStr ?? "")")
//                        receivedResponse(false, [:], nil)
//                    }
//                } catch let parseError {
//                    print(parseError)
//                    // Log the error thrown by `JSONObjectWithData`
//                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    print("Error could not parse JSON: \(jsonStr ?? "")")
//                    receivedResponse(false, [:], nil)
//                }
//            } else {
//                receivedResponse(false, [:], nil)
//            }
//        })
//        task.resume()
//        // ... Handle request headers, like Token
//
//        // ... Perform URLSession data task and handle the response
//    }

    
    
    static public func uploadingDocuments(_ url:String, params: [String:Any], dataArray:[Data]?, dataKey:String, receivedResponse:@escaping (_ succeeded: Bool, _ response:[String:Any],_ data:Data?) -> ())
    {
        let boundary:NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body:NSMutableData = NSMutableData()
        let paramsArray = params.keys
        for item in paramsArray {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        if let dataArr = dataArray, !dataArr.isEmpty {
            dataArr.enumerated().forEach { (data) in
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\(dataKey)\"; filename=\"photoName.jpeg\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append(data.element)
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
        }
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url)
        request.httpMethod = API.HttpMethod.POST.rawValue
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
//        if accessToken.count > 0 {
//            request.setValue("\(accessToken)", forHTTPHeaderField: "Token")
////            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Token")
//        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        task.resume()
    }
    
    //Mark: For single File
    
    static public func uploadingDoc(_ url:String, params: [String:Any], dataArray: Data?, dataKey:String, receivedResponse:@escaping (_ succeeded: Bool, _ response:[String:Any],_ data:Data?) -> ())
    {
        let boundary:NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body:NSMutableData = NSMutableData()
        let paramsArray = params.keys
        for item in paramsArray {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        if let dataArr = dataArray, !dataArr.isEmpty {
            dataArr.enumerated().forEach { (data) in
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\(dataKey)\"; filename=\"photoName.jpeg\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: application/pdf\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                body.append(data.element)
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
        }
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url)
        request.httpMethod = API.HttpMethod.POST.rawValue
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
//        if accessToken.count > 0 {
//            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Token")
//        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        task.resume()
    }
   
// Mark: ChatAI Method
    
    static public func requestToServerChat(_ url: String, params: [String:Any], httpMethod: API.HttpMethod, isZipped:Bool, receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any],_ data:Data?) -> ()){
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let link = ""
        var request = URLRequest(url: URL(string: link + urlString!)!)
        print(request.url?.absoluteString ?? "")
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 20
//        let accessToken = UserDefaultsCustom.getUserData()?.auth_token ?? ""
//        let token = "Bearer op-34dskndj345klndfl7l34kndflkgu8345klnfdghiooy834"
//        print("parameters are :-  \(params)")
//        if accessToken.count > 0 {
//            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
//            print("BearerToken:- \(token)")
//            print("accessToken:- \(accessToken)")
//        }
        if(httpMethod == API.HttpMethod.POST
            || httpMethod == API.HttpMethod.PUT
            || httpMethod == API.HttpMethod.DELETE) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            if isZipped == false {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Encoding: gzip")
            }
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
       
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                
                print("print response is \(response)")
                
                if(response != nil && data != nil) {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                            receivedResponse(true, json, data)
                        } else {
                            let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                            print("Error could not parse JSON: \(jsonStr ?? "")")
                            receivedResponse(false, [:], nil)
                        }
                    } catch let parseError {
                        print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("Error could not parse JSON: '\(jsonStr ?? "")'")
                        receivedResponse(false, [:], nil)
                    }
                } else {
                    receivedResponse(false, [:], nil)
                }
            }
        }
        task.resume()
    }
}






 





