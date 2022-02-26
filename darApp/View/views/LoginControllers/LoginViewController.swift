//
//  LoginViewController.swift
//  darApp
//
//  Created by Hani Mac on 02/08/2021.
//

import UIKit
import GoogleSignIn
class LoginViewController: UIViewController {

    @IBOutlet weak var isPhoneNumberValidImageView: UIImageView!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var phoneEmalUserNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private var presnter = SignInPresnter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initlization(){
        presnter.delegate = self
        passwordTextField.isSecureTextEntry = true
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        phoneEmalUserNameTextField.addTarget(self, action: #selector(phoneFieldListner), for: .editingChanged)
    }
    
    @objc private func phoneFieldListner(){
        if phoneEmalUserNameTextField.text!.count == 10{
            isPhoneNumberValidImageView.image = #imageLiteral(resourceName: "Icon color")
        }else{
            isPhoneNumberValidImageView.image = UIImage(named: "ico - 24 - actions - checkmark_circle")
        }
    }
    
    private func checkData()->Bool{
        return !phoneEmalUserNameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
    }
    
    @IBAction func hidePasswordAction(_ sender: Any) {
        if hidePasswordButton.tag == 0 {
            passwordTextField.isSecureTextEntry = false
            hidePasswordButton.setImage(#imageLiteral(resourceName: "view"), for: .normal)
            hidePasswordButton.tag = 1
        }else{
            passwordTextField.isSecureTextEntry = true
            hidePasswordButton.setImage(#imageLiteral(resourceName: "ico - 24 - ui - hidden_outlined"), for: .normal)
            hidePasswordButton.tag = 0
        }
    }
    
    
    @IBAction func forgetPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPassNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)

    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        if checkData(){
            presnter.login(phone: phoneEmalUserNameTextField.text!, password: passwordTextField.text!)
        }else{
            showAlertAction(title: "Error", message: "There is an Emtpy Field !!")
        }
    }
    
    
    @IBAction func signUpWithGoogle(_ sender: Any) {
        presnter.googleSignInAction()
    }
    
    
    @IBAction func facebookSignUp(_ sender: Any) {
        presnter.facebookSignInAction()
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func registerAsOwnerAction(_ sender: Any) {
    }
    
    
}

extension LoginViewController:SignInPresnterDelegate{
    func showAlertAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func goToMainNav() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    

}
