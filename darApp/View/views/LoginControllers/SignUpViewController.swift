//
//  SignUpViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit
class SignUpViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    private let presnter = SignUpPresnter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intilization()
    }
    
    
    private func intilization(){
        presnter.delegate = self
    }
        
    private func checkData() ->Bool{
        return !fullNameTextField.text!.isEmpty &&
        !emailTextField.text!.isEmpty &&
        !passwordTextField.text!.isEmpty &&
        !cityTextField.text!.isEmpty &&
        !regionTextField.text!.isEmpty &&
        !phoneNumberTextField.text!.isEmpty
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if checkData(){
            presnter.signUpAction(name: fullNameTextField.text!, email: emailTextField.text!, city: cityTextField.text!, region: regionTextField.text!, phone: phoneNumberTextField.text!, password: passwordTextField.text!)
        }else{
            showAlertAction(title: "Error", message: "There is an Empty Fields !!")
        }
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}

extension SignUpViewController:SignUpPresnterDelegate{
    func showAlertAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func goToMainNav() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
}
