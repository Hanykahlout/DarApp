//
//  SimilarTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var darImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setData(data:SimilarData){
        darImage.sd_setImage(with: URL(string: data.image), placeholderImage: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"))
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        priceLabel.text = "$\(data.price)"
    }

}
