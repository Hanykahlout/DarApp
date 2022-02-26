//
//  SearchResultTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 05/08/2021.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var darImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    func setData(result:SearchResultInfo){
        darImageView.image = result.image
        nameLabel.text = result.name
        descriptionLabel.text = result.description
        priceLabel.text = "$\(result.price)"
    }

}
