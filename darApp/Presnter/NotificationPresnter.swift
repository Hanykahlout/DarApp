//
//  NotificationPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit

protocol NotificationPresnterDelegate {
    
}


typealias NotificationDelegate = NotificationPresnterDelegate & UIViewController

class NotificationPresnter:NSObject {
    weak var delegate:NotificationDelegate?
    
    
    func getNotificationData()->[NotificationData]{
        var notification = [NotificationData]()
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        notification.append(.init(image: #imageLiteral(resourceName: "Group 992"), text: "A new home has been posted in the Riyadh region by Khaled", time: Date(), isNew: true))
        return notification
    }
    
}

