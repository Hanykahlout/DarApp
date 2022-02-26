//
//  TypeTableViewCell.swift
//  darApp
//
//  Created by Dev. Hani on 04/09/2021.
//

import UIKit

protocol TypesDelegate {
    func addType(id:Int)
    func deleteType(id:Int)
}



class TypeTableViewCell: UITableViewCell {

    @IBOutlet weak var firstTypeButton: UIButton!
    @IBOutlet weak var firstTypeTitleLabel: UILabel!
    @IBOutlet weak var secondTypeButton: UIButton!
    @IBOutlet weak var secondTypeTitleLabel: UILabel!
    
    private var typeModel:TypeModel!
    var delegate:TypesDelegate?
    
    func setData(data:TypeModel){
        typeModel = data
        firstTypeButton.isSelected = data.firstTypeIsSelected
        firstTypeTitleLabel.text = data.firstTypeName
        if data.isThereSecond{
            secondTypeButton.isHidden = false
            secondTypeTitleLabel.isHidden = false
            secondTypeButton.isSelected = data.secondTypeIsSelected
            secondTypeTitleLabel.text = data.secondTypeName
        }else{
            secondTypeButton.isHidden = true
            secondTypeTitleLabel.isHidden = true
        }
    }
    
    
    @IBAction func firstTypeRadiuoButtonAction(_ sender: Any) {
        firstTypeButton.isSelected = !firstTypeButton.isSelected
        if let delegate = delegate{
            if firstTypeButton.isSelected {
                delegate.addType(id: typeModel.firstTypeId)
            }else{
                delegate.deleteType(id: typeModel.firstTypeId)
            }
        }
        
    }
    
    
    @IBAction func secondTypeRadiuoButtonAction(_ sender: Any) {
        secondTypeButton.isSelected = !secondTypeButton.isSelected
        if let delegate = delegate{
            if secondTypeButton.isSelected {
                delegate.addType(id: typeModel.secondTypeId)
            }else{
                delegate.deleteType(id: typeModel.secondTypeId)
            }
        }
    }
    
    
}
