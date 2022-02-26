//
//  VerifyMobileViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit

class VerifyMobileViewController: UIViewController {
    
    @IBOutlet weak var firstNumberView: UIImageView!
    @IBOutlet weak var secondNumberView: UIImageView!
    @IBOutlet weak var thirdNumberView: UIImageView!
    @IBOutlet weak var fourthNumberView: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    public var phoneNumber:String!
    private let presnter = VerifyMobilePresnter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    func initlization(){
        presnter.delegate = self
        codeTextField.becomeFirstResponder()
        codeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    
    @objc func textFieldDidChange(){
        switch codeTextField.text!.count {
        case 1:
            firstNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            secondNumberView.image = #imageLiteral(resourceName: "1234122")
            thirdNumberView.image = #imageLiteral(resourceName: "1234122")
            fourthNumberView.image = #imageLiteral(resourceName: "1234122")
        case 2:
            firstNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            secondNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            thirdNumberView.image = #imageLiteral(resourceName: "1234122")
            fourthNumberView.image = #imageLiteral(resourceName: "1234122")
        case 3:
            firstNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            secondNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            thirdNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            fourthNumberView.image = #imageLiteral(resourceName: "1234122")
        case 4:
            firstNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            secondNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            thirdNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
            fourthNumberView.image = #imageLiteral(resourceName: "Ellipse 28")
        default:
            firstNumberView.image = #imageLiteral(resourceName: "1234122")
            secondNumberView.image = #imageLiteral(resourceName: "1234122")
            thirdNumberView.image = #imageLiteral(resourceName: "1234122")
            fourthNumberView.image = #imageLiteral(resourceName: "1234122")
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if !codeTextField.text!.isEmpty{
            presnter.verifyCode(phone: phoneNumber, code: codeTextField.text!)
        }else{
            showAlert(title: "Error", message: "There is an Empty Field !!")
        }
    }
    
}


extension VerifyMobileViewController:VerifyMobilePresnterDelegate{
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func goToRestPasswordScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RestPasswordViewController") as! RestPasswordViewController
        vc.phoneNumber = self.phoneNumber
        vc.code = self.codeTextField.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
