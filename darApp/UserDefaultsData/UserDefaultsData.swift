//
//  UserDefaultsData.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import Foundation

class UserDefaultsData{
    
    public static var shard: UserDefaultsData = {
        let userApi = UserDefaultsData()
        return userApi
    }()
    
    func isLoggedIn()->Bool{
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let isLoggedIn = token != nil && token != ""
        return isLoggedIn
    }
    
    func saveUserInfo(userData:UserData){
        UserDefaults.standard.setValue(userData.id, forKey: "ID")
        UserDefaults.standard.setValue(userData.name, forKey: "NAME")
        UserDefaults.standard.setValue(userData.img, forKey: "IMG")
        UserDefaults.standard.setValue(userData.bio, forKey: "BIO")
        UserDefaults.standard.setValue(userData.address, forKey: "ADDRESS")
        UserDefaults.standard.setValue(userData.phone, forKey: "PHONE")
        UserDefaults.standard.setValue(userData.email, forKey: "EMAIL")
    }
    
    func getUserInfo() -> UserData{
        let id = UserDefaults.standard.integer(forKey: "ID")
        let name = UserDefaults.standard.string(forKey: "NAME") ?? ""
        let image = UserDefaults.standard.string(forKey: "IMG") ?? ""
        let bio = UserDefaults.standard.string(forKey: "BIO") ?? ""
        let address = UserDefaults.standard.string(forKey: "ADDRESS") ?? ""
        let phone = UserDefaults.standard.string(forKey: "PHONE") ?? ""
        let email = UserDefaults.standard.string(forKey: "EMAIL") ?? ""
        return UserData.init(id: id, name: name, img: image, bio: bio, address: address, phone: phone, email: email)
    }
    
    func setToken(token:String){
        UserDefaults.standard.setValue("Bearer \(token)", forKey: "TOKEN")
    }
    
    func getToken() -> String{
        return UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    }
    
    func clearToken(){
        UserDefaults.standard.removeObject(forKey: "TOKEN")
    }
    
    func clearUserInfo(){
        UserDefaults.standard.removeObject(forKey: "ID")
        UserDefaults.standard.removeObject(forKey: "NAME")
        UserDefaults.standard.removeObject(forKey: "IMG")
        UserDefaults.standard.removeObject(forKey: "BIO")
        UserDefaults.standard.removeObject(forKey: "ADDRESS")
        UserDefaults.standard.removeObject(forKey: "PHONE")
        UserDefaults.standard.removeObject(forKey: "EMAIL")
        
    }
    
}
