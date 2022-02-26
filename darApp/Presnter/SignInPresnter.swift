//
//  SignInPresnter.swift
//  darApp
//
//  Created by Hani Mac on 15/08/2021.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase
import SVProgressHUD
protocol SignInPresnterDelegate {
    func showAlertAction(title:String,message:String)
    func goToMainNav()
}

typealias SignInDelegate = SignInPresnterDelegate & UIViewController

class SignInPresnter:NSObject{
    weak var delegate:SignInDelegate?
    
    override init(){
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    
    func login(phone:String,password:String){
        APIController.shard.login(phone: phone, password: password) { status, message, data in
            if status == "true"{
                if let data = data{
                    UserDefaultsData.shard.saveUserInfo(userData: data.data!)
                    UserDefaultsData.shard.setToken(token: data.access_token!)
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
    
    
    func googleSignInAction(){
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    func facebookSignInAction(){
        
        let loginManager = LoginManager()
        if let _ = AccessToken.current{
            loginManager.logOut()
        } else {
            loginManager.logIn(permissions: ["public_profile","email"], from: delegate!) { (result, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.delegate?.showAlertAction(title: "Error", message: "There is an error in your login with facebook")
                    }
                    return
                }
                guard let result = result, !result.isCancelled else {
                    return
                }
                
                if let token = AccessToken.current{
                    let cardinate = FacebookAuthProvider.credential(withAccessToken: token.tokenString )
                    self.signInWithCardinateInFirebase(cardinate: cardinate) { status in
                        if status {
                            self.getFacebookUserData { status, email in
                                if status{
                                    APIController.shard.socialLogin(email: email, password: "") { status, message, data in
                                        if status == "true"{
                                            if let data = data{
                                                UserDefaultsData.shard.saveUserInfo(userData: data.data!)
                                                UserDefaultsData.shard.setToken(token: data.access_token!)
                                                DispatchQueue.main.async {
                                                    self.delegate?.goToMainNav()
                                                }
                                            }
                                        }else{
                                            DispatchQueue.main.async {
                                                self.delegate?.showAlertAction(title: "Error", message: "There is an error in your login with facebook")
                                            }
                                        }
                                    }
                                }else{
                                    DispatchQueue.main.async {
                                        self.delegate?.showAlertAction(title: "Error", message: "There is an error in your login with facebook")
                                    }
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.delegate?.showAlertAction(title: "Error", message: "There is an error in your login with facebook")
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    private func getFacebookUserData(callBack:@escaping (_ status:Bool,_ email:String)-> Void) {
        GraphRequest(graphPath: "me", parameters: ["fields":"email"]).start { (_, results, error) in
            if let _ = error{
                callBack(false,"")
                return
            }
            
            let res = results as! [String:Any] as NSDictionary
            let email = res.value(forKey: "email") as! String
            callBack(true,email)
        }
    }
    
    func signInWithCardinateInFirebase(cardinate:AuthCredential,callback: @escaping (_ status:Bool)->Void) {
        SVProgressHUD.show()
        Auth.auth().signIn(with: cardinate) { (authData, error) in
            SVProgressHUD.dismiss()
            if let _ = error{
                callback(false)
            }else{
                callback(true)
            }
        }
    }
    
}

extension SignInPresnter: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken,
                                                       accessToken: user.authentication.accessToken)

        signInWithCardinateInFirebase(cardinate: credential) { status in
            if status{
                APIController.shard.socialLogin(email: user.profile.email!, password: "") { status, message, data in
                    if status == "true"{
                        if let data = data{
                            UserDefaultsData.shard.saveUserInfo(userData: data.data!)
                            UserDefaultsData.shard.setToken(token: data.access_token!)
                            DispatchQueue.main.async {
                                self.delegate?.goToMainNav()
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.delegate?.showAlertAction(title: "Error", message: "There is an error while google sign in")
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: "There is an error while google sign in")
                }
            }
        }

    }
}
