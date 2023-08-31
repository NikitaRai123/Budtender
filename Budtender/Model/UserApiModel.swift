




import Foundation
import Alamofire
import SVProgressHUD

class UserApiModel {
    static let instance  = UserApiModel()
    func userLogin(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.Login, params: (model.convertDict() as? [String:Any]), headers: nil, success: { (response) in
            print(response)
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil,error.debugDescription)
        })
    }

    func userSignUp(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){

        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.SignUp, params: (model.convertDict() as! [String:Any]), headers: nil, success: { (response) in
//            print("parameters===>>>",model.covertDict())
            print(response)
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil, error.debugDescription)
        })
    }

    func userForgotPassword(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){

        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.ForgotPassword, params: (model.convertDict() as! [String:Any]), headers: nil, success: { (response) in
            print(response)
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil, error.debugDescription)
        })
    }
    
    func reportListing(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){

        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.reportListing, params: (model.convertDict() as! [String:Any]), headers: nil, success: { (response) in
            print(response)
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil, error.debugDescription)
        })
    }
    func addReport(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){

        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.addReport, params: (model.convertDict() as! [String:Any]), headers: nil, success: { (response) in
            print(response)
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil, error.debugDescription)
        })
    }
    
    
//    func homeListing(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPOSTSURL(Constant.HomeLisitng, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//
//    func sendShareDetails(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.sendShareDetails, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func addCommentReply(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.AddCommentReply, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func AddCommentfavourite(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.AddCommentfavourite, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getFollower(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getFollower, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getAllchatMsg(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//        AFWrapperClass.sharedInstance.requestPOSTSURL(Constant.getAllChatMsg, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//        
//    }
//    
//    func sendMsg(model: SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//        AFWrapperClass.sharedInstance.sendMessage(strURL: Constant.sendMsg, params: (model.convertDict() as! [String:Any])) { result, message in
//            completion(result as NSDictionary?, message)
//            print(result)
//        }
//
//    }
//    func updateMsg(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.updateMsg, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func deleteFollow(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.deleteFollow, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func createRoom(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.createRoom, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getAllChatUser(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getAllChatUser, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func deleteChatUser(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.deleteChatUser, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getAllCommentList(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getAllCommentList, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func addFollowUnFollow(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.addFollowUnFollow, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    
//    func getNotification(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getNotification, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func AddComment(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.AddComment, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getAllSearchUser(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getAllSearchUser, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func deletePostId(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.deletePostID, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func homeDetails(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.homeDetails, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func saveBookmark(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.SaveBookmark, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func saveBookmarkListing(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.SaveBookmarkListing, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//
//    func changePassword(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.ChangePassword, params: (model.convertDict() as! [String:Any]), headers:  ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func getAllFollowerList(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getAllFollowerList, params: (model.convertDict() as! [String:Any]), headers:  ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func createPost(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//        AFWrapperClass.sharedInstance.upload(strURL: Constant.createPost, params: (model.convertDict() as! [String:Any])) { (response, error) in
//            print("parameters ===== >>> ", model)
//                        if let dict = response{
//                            print("dict ===== >>> ", dict)
//                            completion(response as NSDictionary?,nil)
//                        }
//                        else{
//                            completion(nil,error)
//                        }
//        }
//    }
//    
//    func editPost(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//        AFWrapperClass.sharedInstance.upload(strURL: Constant.editPost, params: (model.convertDict() as! [String:Any])) { (response, error) in
//            print("parameters ===== >>> ", model)
//                        if let dict = response{
//                            print("dict ===== >>> ", dict)
//                            completion(response as NSDictionary?,nil)
//                        }
//                        else{
//                            completion(nil,error)
//                        }
//        }
//    }
//    
//
//    
//    func imageFav(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.imageFav, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            print(AppDefaults.token ?? "","Token")
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func getBlockList(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.blockList, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            print(AppDefaults.token ?? "","Token")
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    func Getreportreason(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPOSTSURL(Constant.getReportReason, params: (model.convertDict() as! [String:Any]), headers: nil, success: { (response) in
//            print(response)
//            print(AppDefaults.token ?? "","Token")
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func blockUnblock(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.AddblockUnblock, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            print(AppDefaults.token ?? "","Token")
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//
    func getProfile(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){

        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getProfile, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
            print(response)
            print(AppDefaults.token ?? "","Token")
            completion(response,nil)
        }, failure: { (error) in
            print(error.debugDescription)
            completion(nil, error.debugDescription)
        })
    }
//    func getOtherProfile(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.getOtherProfile, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            print(AppDefaults.token ?? "","Token")
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    
//    
//    func deleteProfile(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.deleteProfileAccount, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func logoutProfile(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.requestPostWithMultiFormData(Constant.logoutProfile, params: (model.convertDict() as! [String:Any]), headers: ["Token":AppDefaults.token ?? ""], success: { (response) in
//            print(response)
//            completion(response,nil)
//        }, failure: { (error) in
//            print(error.debugDescription)
//            completion(nil, error.debugDescription)
//        })
//    }
//    func editProfile(model:SignupModel,completion: @escaping (NSDictionary?,String?) -> Void){
//
//        AFWrapperClass.sharedInstance.upload(strURL: Constant.editProfile, params: (model.convertDict() as! [String:Any])) { (response, error) in
//            print("parameters ===== >>> ", model)
//                        if let dict = response{
//                            print("dict ===== >>> ", dict)
//                            completion(response as NSDictionary?,nil)
//                        }
//                        else{
//                            completion(nil,error)
//                        }
//        }
//    }
    }

