//
//  HomeTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 26/07/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var favorateButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Dar){
        cellImageView.image = data.image
        priceLabel.text = "$\(data.price)"
        addressLabel.text = data.address
        daysLabel.text = data.daysDescription
        typeLabel.text = data.type
        favorateButton.isSelected = data.isFavorate
    }
    
    @IBAction func favorateAction(_ sender: Any) {
        favorateButton.isSelected = !favorateButton.isSelected
    }
    
}
