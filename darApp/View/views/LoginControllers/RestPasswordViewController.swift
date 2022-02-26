//
//  RestPasswordViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit

class RestPasswordViewController: UIViewController {

    @IBOutlet weak var hideShowPasswordButton: UIButton!
    @IBOutlet weak var hideShowRPasswordButton: UIButton!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newRPasswordTextField: UITextField!
    
    private let presnter = ResetPasswordPresnter()
    public var phoneNumber:String!
    public var code:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    private func initlization(){
        presnter.delegate = self
        newPasswordTextField.isSecureTextEntry = true
        newRPasswordTextField.isSecureTextEntry = true
    }

    private func checkData() -> Bool{
        return !newPasswordTextField.text!.isEmpty && !newRPasswordTextField.text!.isEmpty
    }
    
    @IBAction func hideShowPasswordAction(_ sender: Any) {
        if hideShowPasswordButton.tag == 0 {
            newPasswordTextField.isSecureTextEntry = false
            hideShowPasswordButton.setImage(#imageLiteral(resourceName: "view"), for: .normal)
            hideShowPasswordButton.tag = 1
        }else{
            newPasswordTextField.isSecureTextEntry = true
            hideShowPasswordButton.setImage(#imageLiteral(resourceName: "ico - 24 - ui - hidden_outlined"), for: .normal)
            hideShowPasswordButton.tag = 0
        }
    }
    
    @IBAction func hideShowRPasswordAction(_ sender: Any) {
        if hideShowRPasswordButton.tag == 0 {
            newRPasswordTextField.isSecureTextEntry = false
            hideShowRPasswordButton.setImage(#imageLiteral(resourceName: "view"), for: .normal)
            hideShowRPasswordButton.tag = 1
        }else{
            newRPasswordTextField.isSecureTextEntry = true
            hideShowRPasswordButton.setImage(#imageLiteral(resourceName: "ico - 24 - ui - hidden_outlined"), for: .normal)
            hideShowRPasswordButton.tag = 0
        }
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        if checkData(){
            presnter.changePassword(phoneNumber: phoneNumber, password: newPasswordTextField.text!, Cpassword: newRPasswordTextField.text!, code: code)
        }else{
            showAlertAction(title: "Error", message: "There is an Empty Field !!")
        }
    }
    
}

extension RestPasswordViewController:ResetPasswordPresnterDelegate{
    func showAlertAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func goToDoneResetScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoneRestPasswordViewController") as! DoneRestPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
