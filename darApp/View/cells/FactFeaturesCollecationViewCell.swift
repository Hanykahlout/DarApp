//
//  FactFeaturesTableViewCell.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class FactFeaturesCollecationViewCell: UICollectionViewCell {

    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setData(data:FactData){
        titileLabel.text = data.title
        valueLabel.text = data.value
    }
}
