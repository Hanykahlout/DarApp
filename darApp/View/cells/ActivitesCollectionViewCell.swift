//
//  ActivitesCollectionViewCell.swift
//  darApp
//
//  Created by Hani Mac on 09/08/2021.
//

import UIKit

class ActivitesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var descriptionLabl: UILabel!
    
    
    func setData(data:ActiviteInfo){
        titleLabel.text = data.title
        activityImageView.image = data.image
        descriptionLabl.text = data.description
    }
}

