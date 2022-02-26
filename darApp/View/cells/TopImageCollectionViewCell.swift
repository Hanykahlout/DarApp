//
//  TopImageTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class TopImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var darImageView: UIImageView!
    
    func setEstateImage(imageUrl:String){
        darImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"))
    }
}
