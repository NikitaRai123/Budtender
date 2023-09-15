//
//  ApiHandler.swift
//  CullintonsCustomer
//
//  Created by Nitin Kumar on 03/04/18.
//  Copyright © 2018 Nitin Kumar. All rights reserved.
//

import UIKit

class ApiHandler {

    static public func call(apiName:String, params: [String : Any]?, httpMethod:API.HttpMethod, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(apiName, params: params!, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
                print(isSucceeded)
                print(response)
                print(data)
                DispatchQueue.main.async {
                    print("\n\nAPI name: \(apiName)\n apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["status"] as? Int {
                            print(status)
                            switch (status) {
                            case 200:
                                receivedResponse(true, response, data)
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                }
//                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                Singleton.shared.logoutFromDevice()
//                                receivedResponse(false, [:], nil)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                if let message = response["message"] as? String {
                                    if message == "invalid access token" {
                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                        Singleton.shared.logoutFromDevice()
                                        receivedResponse(false, [:], nil)
                                    } else {
                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
                                    }
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                    Singleton.shared.logoutFromDevice()
                                    receivedResponse(false, [:], nil)
                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            })
        } else {
            receivedResponse(false, ["statusCode": 0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
    }
    
   
    
    static public func uploadImage(apiName:String, dataArray: [PickerData]?, imgs_deleted:[String], params: [String : Any]?, isImage:Bool = true, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params ?? [:], imgs_deleted: imgs_deleted, dataArray: dataArray) { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["status"] as? Int {
                            switch(status) {
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            case 1:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
    }
   
    static public func updateVideo(apiName: String, params: [String:Any],video: PickerData? = nil, thumbnailImage: UIImage? ,receivedResponse: @escaping(_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()){
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params, video: video, thumbnailImage: thumbnailImage){ (isSucceeded, response, data) in
                print(isSucceeded)
                 print(response)
                 print(data)
                DispatchQueue.main.async {
                    print("\n\nAPI name: \(apiName)\n apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["status"] as? Int {
                            switch (status) {
                            case 1:
                                receivedResponse(true, response, data)
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                                
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                if let message = response["message"] as? String {
                                    if message == "invalid access token" {
                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                        Singleton.shared.logoutFromDevice()
                                        receivedResponse(false, [:], nil)
                                    } else {
                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
                                    }
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                    Singleton.shared.logoutFromDevice()
                                    receivedResponse(false, [:], nil)
                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
            }else {
                receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
            }
    }
    
    
    static public func updateProfile(apiName:String, params: [String:Any], profilePhoto: PickerData? = nil, coverPhoto: PickerData? = nil,receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params, profilePhoto: profilePhoto, coverPhoto: coverPhoto) { (isSucceeded, response, data) in
               print(isSucceeded)
                print(response)
                print(data)
                DispatchQueue.main.async {
                    print("\n\nAPI name: \(apiName)\n apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["status"] as? Int {
                            print(status)
                            switch (status) {
                            case 200:
                                receivedResponse(true, response, data)
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                }
//                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                Singleton.shared.logoutFromDevice()
//                                receivedResponse(false, [:], nil)
                           
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                if let message = response["message"] as? String {
                                    if message == "invalid access token" {
                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                        Singleton.shared.logoutFromDevice()
                                        receivedResponse(false, [:], nil)
                                    } else {
                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
                                    }
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                    Singleton.shared.logoutFromDevice()
                                    receivedResponse(false, [:], nil)
                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
    
    
    static public func updateProfileHome(apiName:String, params: [String:Any], profilePhoto: PickerData? = nil, coverPhoto: PickerData? = nil,receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params, profilePhoto: profilePhoto, coverPhoto: coverPhoto) { (isSucceeded, response, data) in
               print(isSucceeded)
                print(response)
                print(data)
                DispatchQueue.main.async {
                    print("\n\nAPI name: \(apiName)\n apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["status"] as? Int {
                            switch (status) {
                            case 1:
                                receivedResponse(true, response, data)
                            case 0 :
                                receivedResponse(true, response, data)
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                           
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                if let message = response["message"] as? String {
                                    if message == "invalid access token" {
                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                        Singleton.shared.logoutFromDevice()
                                        receivedResponse(false, [:], nil)
                                    } else {
                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
                                    }
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                    Singleton.shared.logoutFromDevice()
                                    receivedResponse(false, [:], nil)
                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
    
    static public func uploadDocument(apiName:String, dataArray:[Data]?, dataKey:String, params: [String : Any]?, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingDocuments(apiName, params: params ?? [:], dataArray: dataArray, dataKey: dataKey) { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["code"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                receivedResponse(true, response, data)
                            
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
    
// Mark: for Single File
    
    static public func uploadDoc(apiName:String, dataArray:Data?, dataKey:String, params: [String : Any]?, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            
            HttpManager.uploadingDoc(apiName, params: params ?? [:], dataArray: dataArray, dataKey: dataKey) { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["code"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                receivedResponse(true, response, data)
                            
                            case API.statusCodes.UNAUTHORIZED_ACCESS:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
  
    //Mark: For ChatAI
    static public func callChat(apiName:String, params: [String : Any]?, httpMethod:API.HttpMethod, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServerChat(apiName, params: params!, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print("\n\nAPI name: \(apiName)\n apiHandler responce:- \(response)")
                    print("params:-     \(params)")
                    if(isSucceeded) {
                        if let status = response["success"] as? Bool {
                            print(status)
                            switch (status) {
                            case true:
                                receivedResponse(true, response, data)
//                            case API.statusCodes.UNAUTHORIZED_ACCESS:
//                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                Singleton.shared.logoutFromDevice()
//                                receivedResponse(false, [:], nil)
//                            case API.statusCodes.INVALID_ACCESS_TOKEN:
//                                if let message = response["message"] as? String {
//                                    if message == "invalid access token" {
//                                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                        Singleton.shared.logoutFromDevice()
//                                        receivedResponse(false, [:], nil)
//                                    } else {
//                                        receivedResponse(false, ["statusCode": status, "message": message], nil)
//                                    }
//                                } else {
//                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
//                                    Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                    Singleton.shared.logoutFromDevice()
//                                    receivedResponse(false, [:], nil)
//                                }
                            default:
                                if response["data"] != nil, let message = response["message"] as? String {
                                    receivedResponse(true, ["statusCode": 1, "message": message, "data": []], nil)
                                } else
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["statusCode": status, "message": message], nil)
                                } else {
                                    receivedResponse(false, ["statusCode": status, "message": AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            })
        } else {
            receivedResponse(false, ["statusCode": 0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
    }
    
    
    
}




