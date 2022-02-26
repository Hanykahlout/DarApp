//
//  ForgetPasswordPresnter.swift
//  darApp
//
//  Created by Hani Mac on 16/08/2021.
//

import UIKit

protocol ForgetPasswordPresnterDelegate {
    func showAlert(title:String,message:String)
    func goToVerifyScreen()
}

typealias ForgetPasswordDelegate = ForgetPasswordPresnterDelegate & UIViewController


class ForgetPasswordPresnter:NSObject{
    
    weak var delegate:ForgetPasswordDelegate?
    
    
    func restPassword(phone:String){
        APIController.shard.restPassword(phone: phone) { status, message, data in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.goToVerifyScreen()
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
}


