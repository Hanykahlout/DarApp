//
//  VerifyMobilePresnter.swift
//  darApp
//
//  Created by Hani Mac on 16/08/2021.
//

import UIKit


protocol VerifyMobilePresnterDelegate {
    func showAlert(title:String,message:String)
    func goToRestPasswordScreen()
}

typealias VerifyMobileDelegate = VerifyMobilePresnterDelegate & UIViewController


class VerifyMobilePresnter: NSObject {
    
    weak var delegate:VerifyMobileDelegate?
    
    
    func verifyCode(phone:String,code:String){
        APIController.shard.verifyCode(phone: phone, code: code) { status, message, data in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.goToRestPasswordScreen()
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
     
}
