//
//  MessagesPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit


protocol MessagesPresnterDelegate {
    func setBottomConstrant(height:CGFloat)
}

typealias MessagesDelegate = MessagesPresnterDelegate & UIViewController

class MessagesPresnter:NSObject {
    
    weak var delegate:MessagesDelegate?
    private var keyboardHeight:CGFloat = 0.0
    
    func getMessages()->[MessageInfo]{
        var messages =  [MessageInfo]()
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You", isMeSender: false, type: "text"))
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You", isMeSender: false, type: "text"))
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You", isMeSender: false, type: "text"))
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You", isMeSender: false, type: "text"))
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You", isMeSender: false, type: "text"))
        messages.append(.init(text: "Hello Man", isMeSender: true, type: "text"))
        messages.append(.init(text: "Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You v Hi, How are You v v Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You Hi, How are You", isMeSender: false, type: "text"))
        return messages
    }
    
    func getOtherUserData() -> (image:UIImage,name:String){
        return (image:#imageLiteral(resourceName: "Group 992"),name:"Hany Alkahlout")
    }
    
    func setUpKeyboardHeight(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height - 34
            delegate?.setBottomConstrant(height: keyboardHeight)
        }
    }
    
    func getKeyboardHeight() ->CGFloat{
        return keyboardHeight
    }
    

}



