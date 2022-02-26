//
//  FilterFeatureTableViewCell.swift
//  darApp
//
//  Created by Dev. Hani on 08/09/2021.
//

import UIKit

protocol FilterFeaturesCellDelegate{
    func appendToAll(button:UIButton)
    func select(title:String,button:UIButton)
}



class FilterFeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var firstFeatureRadioButton: UIButton!
    @IBOutlet weak var secondFeatureRadioButton: UIButton!
    @IBOutlet weak var firstFeatureTitleLabel: UILabel!
    @IBOutlet weak var secondFeatureTitleLabel: UILabel!
    
    var delegate:FilterFeaturesCellDelegate?
    
    func setData(data:TypeModel){
        firstFeatureRadioButton.isSelected = data.firstTypeIsSelected
        firstFeatureTitleLabel.text = data.firstTypeName
        delegate?.appendToAll(button: firstFeatureRadioButton)
        if data.isThereSecond{
            secondFeatureRadioButton.isSelected = data.secondTypeIsSelected
            secondFeatureTitleLabel.text = data.secondTypeName
            delegate?.appendToAll(button: secondFeatureRadioButton)
            secondFeatureRadioButton.isHidden = false
            secondFeatureTitleLabel.isHidden = false
        }else{
            secondFeatureRadioButton.isHidden = true
            secondFeatureTitleLabel.isHidden = true
        }
    }
    
    @IBAction func firstFeatureAction(_ sender: Any) {
        delegate?.select(title:firstFeatureTitleLabel.text!,button: firstFeatureRadioButton)
    }

    @IBAction func secondFeatureAction(_ sender: Any) {
        delegate?.select(title:secondFeatureTitleLabel.text!,button: secondFeatureRadioButton)
    }
    
    
    
}
