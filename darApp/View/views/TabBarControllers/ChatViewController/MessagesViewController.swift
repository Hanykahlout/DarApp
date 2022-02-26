//
//  MessagesViewController.swift
//  darApp
//
//  Created by Hani Mac on 04/08/2021.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var otherUserImageView: UIImageView!
    @IBOutlet weak var otherUserNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messaeTextFieldViewBottomConstrant: NSLayoutConstraint!
    private var messages = [MessageInfo]()
    private let presnter = MessagesPresnter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = presnter.getMessages()
        let otherUserData = presnter.getOtherUserData()
        otherUserImageView.image = otherUserData.image
        otherUserNameLabel.text = otherUserData.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        messageTextField.delegate = self
        presnter.delegate = self
        setUpTableView()
        presnter.setUpKeyboardHeight()
        messagesTableView.isUserInteractionEnabled = true
        messagesTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTableView)))
    }
        
    @objc private func didTapTableView(){
        messaeTextFieldViewBottomConstrant.constant -= presnter.getKeyboardHeight()
        messageTextField.endEditing(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func sendAction(_ sender: Any) {
    }
    
    
    @IBAction func voiceMessageAction(_ sender: Any) {
    }
    
    
    @IBAction func cameraMessageAction(_ sender: Any) {
    }
    
}

extension MessagesViewController:UITableViewDelegate,UITableViewDataSource{
    
    private func setUpTableView(){
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.isMeSender{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyTextMessageTableViewCell", for: indexPath) as! MyTextMessageTableViewCell
            cell.textMessageLabel.text = messages[indexPath.row].text
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTextMessageTableViewCell", for: indexPath) as! OtherTextMessageTableViewCell
        cell.textMessageLabel.text = messages[indexPath.row].text
        return cell
    }

    
}

extension MessagesViewController:MessagesPresnterDelegate{
    func setBottomConstrant(height: CGFloat) {
        messaeTextFieldViewBottomConstrant.constant = height
    }
    
}

extension MessagesViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapTableView()
        return true
    }
}
