//
//  ChatTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 04/08/2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func setData(chatInfo:ChatInfo){
        userImageView.image = chatInfo.image
        userNameLabel.text = chatInfo.name
        lastMessageLabel.text = chatInfo.lastMessage
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm a"
        timeLabel.text = dateFormatter.string(from: chatInfo.time)
        
    }

}
