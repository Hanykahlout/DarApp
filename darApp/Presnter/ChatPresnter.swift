//
//  ChatPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit

protocol ChatPresnterDelegate {
    
}
typealias ChatDelegate = ChatPresnterDelegate & UIViewController


class ChatPresnter: NSObject {
    weak var delegate:ChatDelegate?
    
    func getChatsData()->[ChatInfo]{
        var chatsInfo:[ChatInfo] = [ChatInfo]()
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        chatsInfo.append(.init(image: #imageLiteral(resourceName: "Group 992"), name: "Company Name", lastMessage: "That's great, I can help you with that! What type of product are you...", time: Date()))
        return chatsInfo
    }

}
