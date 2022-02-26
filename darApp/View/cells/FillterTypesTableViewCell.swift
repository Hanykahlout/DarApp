//
//  FillterTypesTableViewCell.swift
//  darApp
//
//  Created by Dev. Hani on 06/09/2021.
//

import UIKit


protocol FillterCellDelegate {
    func appendButtonToAll(button:UIButton)
    func select(title:String,id:Int,button:UIButton)
}



class FillterTypesTableViewCell: UITableViewCell {

    @IBOutlet weak var firstTypeRadioButton: UIButton!
    @IBOutlet weak var firstTypeTitleLabel: UILabel!
    @IBOutlet weak var secondTypeRadioButton: UIButton!
    @IBOutlet weak var secondTypeTitleLabel: UILabel!
    
    private var firstTypeId:Int!
    private var secondTypeId:Int!
    
    var delegate:FillterCellDelegate?
    
    func setData(data:TypeModel,indexPath:IndexPath){
        if indexPath.row == 0{
            firstTypeRadioButton.isSelected = true
            delegate?.select(title: data.firstTypeName,id:data.firstTypeId,button: firstTypeRadioButton)
        }else{
            firstTypeRadioButton.isSelected = data.firstTypeIsSelected
        }
        firstTypeTitleLabel.text = data.firstTypeName
        firstTypeId = data.firstTypeId
        delegate?.appendButtonToAll(button: firstTypeRadioButton)
        if data.isThereSecond{
            secondTypeRadioButton.isHidden = false
            secondTypeTitleLabel.isHidden = false
            secondTypeRadioButton.isSelected = data.secondTypeIsSelected
            secondTypeTitleLabel.text = data.secondTypeName
            secondTypeId = data.secondTypeId
            delegate?.appendButtonToAll(button: secondTypeRadioButton)
        }else{
            secondTypeRadioButton.isHidden = true
            secondTypeTitleLabel.isHidden = true
        }
    }
    
    
    @IBAction func firstTypeAction(_ sender: Any) {
        delegate?.select(title:firstTypeTitleLabel.text!,id:firstTypeId,button: firstTypeRadioButton)
    }
    
    
    @IBAction func secondTypeAction(_ sender: Any) {
        delegate?.select(title:secondTypeTitleLabel.text!,id:secondTypeId,button: secondTypeRadioButton)
    }
    
    
}
