//
//  SignUpPresnter.swift
//  darApp
//
//  Created by Hani Mac on 15/08/2021.
//

import UIKit

protocol SignUpPresnterDelegate {
    func showAlertAction(title:String,message:String)
    func goToMainNav()
}

typealias SignUpDelegate = SignUpPresnterDelegate & UIViewController

class SignUpPresnter:NSObject{
    
    weak var delegate:SignUpDelegate?
    
    func signUpAction(name:String,email:String,city:String,region:String,phone:String,password:String){
        APIController.shard.register(name: name, email: email, city: city, region: region, phone: phone, password: password) { status, message, data in
            if status == "true"{
                if let data = data{
                    UserDefaultsData.shard.setToken(token: data.access_token!)
                    UserDefaultsData.shard.saveUserInfo(userData: data.data!)
                    DispatchQueue.main.async {
                        self.delegate?.goToMainNav()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
}

