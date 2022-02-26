//
//  NotificationTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 01/08/2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var notificationTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(notification:NotificationData){
        senderImageView.image = notification.image
        notificationTextLabel.text = notification.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm a"
        timeLabel.text = dateFormatter.string(from: notification.time)
    }
    

}
