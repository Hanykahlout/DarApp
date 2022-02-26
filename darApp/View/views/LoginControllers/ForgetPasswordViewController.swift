//
//  ForgetPasswordViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    private let presnter = ForgetPasswordPresnter()
    
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
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        if !phoneNumberTextField.text!.isEmpty{
            presnter.restPassword(phone: phoneNumberTextField.text!)
        }else{
            showAlert(title: "Error", message: "You Have To Enter Your Phone Number")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}


extension ForgetPasswordViewController:ForgetPasswordPresnterDelegate{
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func goToVerifyScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VerifyMobileViewController") as! VerifyMobileViewController
        vc.phoneNumber = phoneNumberTextField.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
