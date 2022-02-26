//
//  MyInfoPresnter.swift
//  darApp
//
//  Created by Hani Mac on 17/08/2021.
//

import UIKit

protocol MyInfoPresnterDelegate {
    func showAlert(title:String,message:String)
    func setUserData(userName:String,region:String,email:String,phoneNumber:String,password:String)
    func setPersonalImage(url:String)
    func setBGImage(url:String)
}

typealias MyInfoDelegate = MyInfoPresnterDelegate & UIViewController


class MyInfoPresnter:NSObject{
    
    weak var delegate:MyInfoDelegate?

    func getUserData(){
        APIController.shard.getUserData { status, message, data in
            if status == "true"{
                if let data = data{
                    DispatchQueue.main.async {
                        self.delegate?.setUserData(userName: data.name ?? "", region: data.address ?? "", email: data.email ?? "", phoneNumber: data.phone ?? "", password: "")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func updateUserInfo(field:FieldChange,name:String?,email:String?,phone:String?,password:String?){
        APIController.shard.updateUserInfo(field:field,name: name, email: email, phone: phone, password: password) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Successfully Updated", message: message)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func uploadPersonalImageToFirbaseStorage(profileName:String,image:UIImage){
        FStorage.shard.uploadImage(profileName: profileName, uid: String(UserDefaultsData.shard.getUserInfo().id!), imageData: image.jpegData(compressionQuality: 0.4)!) { status, url in
            if status{
                FFirestore.shard.savePersonalImageURL(userID: String(UserDefaultsData.shard.getUserInfo().id!), personalImageURL: url) { status in
                    if status{
                        DispatchQueue.main.async {
                            self.delegate?.showAlert(title: "Successfully", message: "Your profile picture has been successfully changed")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.delegate?.showAlert(title: "Failed", message: "Failed to change your profile picture")
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Failed", message: "Failed to change your profile picture")
                }
            }
        }
    }
    
    func uploadBGImageToFirbaseStorage(profileName:String,image:UIImage){
        FStorage.shard.uploadImage(profileName: profileName, uid: String(UserDefaultsData.shard.getUserInfo().id!), imageData: image.jpegData(compressionQuality: 0.4)!) { status, url in
            if status{
                FFirestore.shard.saveBGImageURL(userID: String(UserDefaultsData.shard.getUserInfo().id!),BGImageURL: url) { status in
                    if status{
                        DispatchQueue.main.async {
                            self.delegate?.showAlert(title: "Successfully", message: "Your Background picture has been successfully changed")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.delegate?.showAlert(title: "Failed", message: "Failed to change your Background picture")
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Failed", message: "Failed to change your Background picture")
                }
            }
        }
    }
    
    func getPersonalImage(){
        FFirestore.shard.getImageUrl(userID: String(UserDefaultsData.shard.getUserInfo().id!), imageType: .personal) { status, url in
            if status{
                DispatchQueue.main.async {
                    self.delegate?.setPersonalImage(url: url)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Failed", message: "Failed to Get your personal picture")
                }
            }
        }
    }
    
    
    func getBGImage(){
        FFirestore.shard.getImageUrl(userID: String(UserDefaultsData.shard.getUserInfo().id!), imageType: .BG) { status, url in
            if status{
                DispatchQueue.main.async {
                    self.delegate?.setBGImage(url: url)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Failed", message: "Failed to Get your Background picture")
                }
            }
        }
    }
    
}


