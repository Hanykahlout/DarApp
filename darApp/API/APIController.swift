//
//  APIController.swift
//  darApp
//
//  Created by Hani Mac on 15/08/2021.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import SVProgressHUD

class APIController{
    
    public static var shard: APIController = {
        let controller = APIController()
        return controller
    }()
    
    
    func register(name:String,email:String,city:String,region:String,phone:String,password:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["name":name,"email":email,"city":city,"region":region,"phone":phone,"password":password]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Register.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    func login(phone:String,password:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["phone":phone,"password":password]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Login.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    func socialLogin(email:String,password:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["email":email,"password":password]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Social_Login.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    func restPassword(phone:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["phone":phone]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Rest_Password.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    func verifyCode(phone:String,code:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["phone":phone,"code":code]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Check_Code_It_True.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    func changePassword(phone:String,password:String,Cpassword:String,code:String,callBack:@escaping (_ status:String,_ message:String,_ data:ResponseData?)->Void){
        let headers:HTTPHeaders = ["Accept-Language":"en"]
        let parme = ["phone":phone,"password":password,"Cpassword":Cpassword,"code":code]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Change_Password_After_Check_Code.url,method: .post,parameters: parme,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    
    
    func getUserData(callBack:@escaping (_ status:String,_ message:String,_ data:UserData?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Get_Date_From_Of_User.url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponse<UserData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    func updateUserInfo(field:FieldChange,name:String?,email:String?,phone:String?,password:String?,callBack:@escaping (_ status:String,_ message:String)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        
        var param:[String:String] = [String:String]()
        switch field {
        case .email:
            param[field.rawValue] = email!
        case .password:
            param[field.rawValue] = password!
        case .phone:
            param[field.rawValue] = phone!
        case .name:
            param[field.rawValue] = name!
        }
        SVProgressHUD.show()
        Alamofire.request(API_URLs.Update.url,method: .patch,parameters: param,headers: headers).responseObject { (response:DataResponse<BaseResponse<UserData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!)
                    return
                }
            }
            callBack("false","Internet Connection Error")
        }
    }
    
    
    func getMapData(lat:String,lng:String,space:String,type:String,callBack:@escaping (_ status:String,_ message:String,_ data:Home_Google_Data?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let url = API_URLs.Home_Map_Copy.withOneToFourIDs(id1: lat, id2: lng, id3: space, id4: type)
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponse<Home_Google_Data>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    func getHomeData(by id:String,callBack:@escaping (_ status:String,_ message:String,_ data:HomeInfoData?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let url = API_URLs.Esate.withOneToFourIDs(id1: id, id2: "", id3: "", id4: "")
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponse<HomeInfoData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    func addToFavorit(by id:String,callBack:@escaping (_ status:String,_ message:String)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let url = API_URLs.Add_Favorite.withOneToFourIDs(id1: id, id2: "", id3: "", id4: "")
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!)
                    return
                }
            }
            callBack("false","Internet Connection Error")
        }
    }
    
    func deleteFromFavorit(by id:String,callBack:@escaping (_ status:String,_ message:String)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let param = ["ads_id":id]
        let url = API_URLs.Delete_Favorite.url
        SVProgressHUD.show()
        Alamofire.request(url,method: .delete,parameters: param,headers: headers).responseObject { (response:DataResponse<BaseResponse<ResponseData>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!)
                    return
                }
            }
            callBack("false","Internet Connection Error")
        }
    }
    
    func getAllFavorits(callBack:@escaping (_ status:String,_ message:String,_ data:[Estate]?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let url = API_URLs.Delete_Favorite.url
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    func visitRequest(id:String,date:String,time:String,phone:String,message:String,callBack:@escaping (_ status:String,_ message:String)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let param = ["estate_id":id,"date":date,"time":time,"phone":phone,"message":message]
        let url = API_URLs.Request_Visit.url
        SVProgressHUD.show()
        Alamofire.request(url,method: .post,parameters: param,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!)
                    return
                }
            }
            callBack("false","Internet Connection Error")
        }
    }
    
    func updateRate(ownerId:Int,rate:Double,callBack:@escaping (_ status:String,_ message:String)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let param:Parameters = ["owner_id":ownerId,"rate":rate]
        let url = API_URLs.Rate.url
        SVProgressHUD.show()
        Alamofire.request(url,method: .post,parameters: param,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!)
                    return
                }
            }
            callBack("false","Internet Connection Error")
        }
    }

    
    func fillterEstate(by types:[Int],type:String,callBack:@escaping (_ status:String,_ message:String,_ data:[Estate]?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        var url = API_URLs.Home_Fillter.withOneToFourIDs(id1: type, id2: "", id3: "", id4: "")
        for id in types {
            url += "type[]=\(id)&"
        }
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }
    
    func fillterEstate(priceFrom:String,priceTo:String,type:String,callBack:@escaping (_ status:String,_ message:String,_ data:[Estate]?)->Void){
        let token  = UserDefaultsData.shard.getToken()
        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
        let url = API_URLs.Home_FillterWithPrice.withOneToFourIDs(id1: type, id2: priceFrom, id3: priceTo, id4: "")
        print("URL --> \(url)")
        SVProgressHUD.show()
        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let basedResponse = response.result.value{
                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
                    return
                }
            }
            callBack("false","Internet Connection Error",nil)
        }
    }


//    func masterFilter(masterType:String,type:String,priceFrom:String,priceTo:String,spaceFrom:String,spaceTo:String,bedrooms:String,bathrooms:String,livingRoom:String,floorNumber:String,stateAge:String,otherFeatuer:[String],callBack:@escaping (_ status:String,_ message:String,_ data:[Estate]?)->Void){
//        let token  = UserDefaultsData.shard.getToken()
//        let headers:HTTPHeaders = ["Authorization":token,"Accept-Language":"en"]
//        let ids:[String] = [masterType,type,priceFrom,priceTo,spaceFrom,spaceTo,bedrooms,bathrooms]
//        let url = API_URLs.Master_Fillter.with24IDs(arr24IDs: ids)
//        print("URL --> \(url)")
//        SVProgressHUD.show()
//        Alamofire.request(url,method: .get,headers: headers).responseObject { (response:DataResponse<BaseResponseArray<Estate>>) in
//            SVProgressHUD.dismiss()
//            if response.result.isSuccess{
//                if let basedResponse = response.result.value{
//                    callBack(basedResponse.status!.status!,basedResponse.status!.message!,basedResponse.data)
//                    return
//                }
//            }
//            callBack("false","Internet Connection Error",nil)
//        }
//    }
    
}


enum FieldChange:String{
    case phone = "phone"
    case name = "name"
    case email = "email"
    case password = "password"
}


