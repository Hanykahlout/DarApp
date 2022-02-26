//
//  MyInfoViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit
import SDWebImage
class MyInfoViewController: UIViewController {

    @IBOutlet weak var userBGImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var reginTextField: UITextField!
    @IBOutlet weak var userNameLineView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberLineView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLineView: UIView!
    private let presnter = MyInfoPresnter()
    private var isPersonalImage = true
    private var textFieldsValues = [String:String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        presnter.delegate = self
        setupImages()
    }
    
    
    private func setupImages(){
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectNewImageAction)))
        userBGImageView.isUserInteractionEnabled = true
        userBGImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectNewBGImageAction)))
    }
    
    
    
    
    @objc private func selectNewBGImageAction(){
        isPersonalImage = false
        showChooseAlert()
    }
    
    @objc private func selectNewImageAction(){
        isPersonalImage = true
        showChooseAlert()
    }
    
    private func showChooseAlert(){
        let alert = UIAlertController(title: "New Image", message: "Please Choose Your Choice", preferredStyle: .actionSheet)
        alert.addAction(.init(title: "Photos", style: .default, handler: { action in
            self.setImageBy(source: .photoLibrary)
        }))
        alert.addAction(.init(title: "Camera", style: .default, handler: { action in
            self.setImageBy(source: .camera)
        }))
        alert.addAction(.init(title: "Cancel", style: .cancel,handler: nil))
                        
        present(alert, animated: true, completion: nil)
    }
    
    private func getUserData(){
        if userImageView.image != UIImage(named: "Group 1117122")!{
            presnter.getPersonalImage()
        }
        
        if userBGImageView.image != UIImage(named: "Group 1117122")!{
            presnter.getBGImage()
        }
        
        presnter.getUserData()
    }


    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaultsData.shard.clearUserInfo()
        UserDefaultsData.shard.clearToken()
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    @IBAction func editUserNameAction(_ sender: Any) {
        userNameLineView.isHidden = !userNameLineView.isHidden
        userNameTextField.isEnabled = !userNameTextField.isEnabled
        if !userNameTextField.isEnabled {
            if !userNameTextField.text!.isEmpty{
                presnter.updateUserInfo(field: .name, name: userNameTextField.text!, email: nil, phone: nil, password: nil)
            }else{
                showAlert(title: "Error", message: "Empty Field !!")
            }
        }
            
    }
    
    @IBAction func editEmailAdressAction(_ sender: Any) {
        emailLineView.isHidden = !emailLineView.isHidden
        emailTextField.isEnabled = !emailTextField.isEnabled
        if !emailTextField.isEnabled {
            if !emailTextField.text!.isEmpty{
                presnter.updateUserInfo(field: .email, name: nil, email: emailTextField.text!, phone: nil, password: nil)
            }else{
                showAlert(title: "Error", message: "Empty Field !!")
            }
        }
    }
    
    @IBAction func editPhoneNumberAction(_ sender: Any) {
        phoneNumberLineView.isHidden = !phoneNumberLineView.isHidden
        phoneNumberTextField.isEnabled = !phoneNumberTextField.isEnabled
        if !phoneNumberTextField.isEnabled {
            if !phoneNumberTextField.text!.isEmpty{
                presnter.updateUserInfo(field: .phone, name: nil, email: nil, phone: phoneNumberTextField.text!, password: nil)
            }else{
                showAlert(title: "Error", message: "Empty Field !!")
            }
        }
    }
    
    @IBAction func editPasswordAction(_ sender: Any) {
        passwordLineView.isHidden = !passwordLineView.isHidden
        passwordTextField.isEnabled = !passwordTextField.isEnabled
        if !passwordTextField.isEnabled {
            if !passwordTextField.text!.isEmpty{
                presnter.updateUserInfo(field: .password, name: nil, email: nil, phone: nil, password: passwordTextField.text!)
            }else{
                showAlert(title: "Error", message: "Empty Field !!")
            }
        }
    }
    
}

extension MyInfoViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isPersonalImage{
            if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                userImageView.image = editingImage
            }else if let orginalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                userImageView.image = orginalImage
            }
            presnter.uploadPersonalImageToFirbaseStorage(profileName: "PersonalImages",image: userImageView.image!)
        }else{
            if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                userBGImageView.image = editingImage
            }else if let orginalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                userBGImageView.image = orginalImage
            }
            presnter.uploadBGImageToFirbaseStorage(profileName: "BGImages",image: userBGImageView.image!)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension MyInfoViewController:MyInfoPresnterDelegate{
    func setPersonalImage(url: String) {
        userImageView.sd_setImage(with: URL(string:url), placeholderImage: #imageLiteral(resourceName: "Group 1117122"))
    }
    
    func setBGImage(url: String) {
        userBGImageView.sd_setImage(with: URL(string:url), placeholderImage: #imageLiteral(resourceName: "Group 1117122"))
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func setUserData(userName: String, region: String, email: String, phoneNumber: String, password: String) {
        userNameTextField.text = userName
        reginTextField.text = region
        emailTextField.text = email
        phoneNumberTextField.text = phoneNumber
        passwordTextField.text = "*********"
    }
    
}

