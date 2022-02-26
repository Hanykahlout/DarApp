//
//  FavoriteTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 01/08/2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var darImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabe: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func setData(data:FavoriteData){
        darImageView.image = data.image
        addressLabel.text = data.address
        priceLabe.text = "\(data.price) SA/Monthly"
        typeLabel.text = data.type
        categoryLabel.text = data.category
    }
    
}
