//
//  ResetPasswordPresnter.swift
//  darApp
//
//  Created by Hani Mac on 16/08/2021.
//

import UIKit

protocol ResetPasswordPresnterDelegate {
    func showAlertAction(title:String,message:String)
    func goToDoneResetScreen()
}

typealias ResetPasswordDelegate = ResetPasswordPresnterDelegate & UIViewController


class ResetPasswordPresnter: NSObject {
    weak var delegate:ResetPasswordDelegate?
    
    
    func changePassword(phoneNumber:String,password:String,Cpassword:String,code:String){
        APIController.shard.changePassword(phone: phoneNumber, password: password, Cpassword: Cpassword, code: code) { status, message, data in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.goToDoneResetScreen()
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
    
    
}
