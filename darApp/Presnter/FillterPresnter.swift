//
//  FillterPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit
protocol FillterPresnterDelegate {
    func changeHomeTypeTableViewHeight(height:CGFloat)
    func changeOtherFeatureTableViewHeight(height:CGFloat)
    func chooseViewToShow(selectedTypeTitle:String)
    func reloadOtherFeaturesTableView()
    func reloadHomeTypesTableView()
}

typealias FillterDelegate = FillterPresnterDelegate & UIViewController


class FillterPresnter:NSObject{
    weak var delegate:FillterDelegate?
    
    private var typesButtons = [UIButton]()
    private var selectedTypeButton = UIButton()
    
    private var featuresButtons = [UIButton]()
    private var selectedFeatures = [String]()
    
    private var selectedButtonId = -1
    private var selectedTypeTitle = ""
    private var homeType:[String:[Categories]] = [String:[Categories]]()
    private var otherFeatures:[String:[String]] = [String:[String]]()
    
    private var selectedSpecializationButton:String = "residential"
    private var selectedForWhatButton:String = "For Sale"
    
    
    override init() {
        super.init()
        setTypesData()
        setFeaturesData()
    }
    
    
    func applyAction(){
        print("The ID For Selected Type Is: \(selectedButtonId)")
        print("Selected Other Features Is: \(selectedFeatures)")
        
    }
    
    
    private func setTypesData(){
        homeType["residentialS"] = [Categories(id: 2, name: "floor"),Categories(id: 8, name: "building"),Categories(id: 3, name: "villa"),Categories(id: 1, name: "apartment"),Categories(id: 11, name: "land")]
        
        homeType["residentialR"] = [Categories(id: 2, name: "floor"),Categories(id: 8, name: "building"),Categories(id: 3, name: "villa"),Categories(id: 1, name: "apartment")]
        
        homeType["commercial"] = [Categories(id: 7, name: "warehouse"),Categories(id: 9, name: "office"),Categories(id: 8, name: "building"),Categories(id: 11, name: "land"),Categories(id: 4, name: "retail")]
        
        homeType["agricultural"] = [Categories(id: 11, name: "land"),Categories(id: 10, name: "resort"),Categories(id: 5, name: "farm")]
    }
    
    
    private func setFeaturesData(){
        let allFeatures = ["electricity" , "internet" , "water", "sewage" , "kitchen", "furnitured", "maids room" , "driver room", "conditioner" , "rooftop"]
        let someFeatures = ["electricity" , "internet" , "water", "sewage" , "kitchen", "furnitured", "maids room" , "driver room", "conditioner"]
        let littleFeatures = ["internet" , "water", "sewage"]
        otherFeatures["residentialA"] = allFeatures
        otherFeatures["residentialS"] = someFeatures
        otherFeatures["residentialL"] = littleFeatures
    }
    
    
    func getHomeTypes()->[TypeModel]{
        if selectedSpecializationButton == "residential"{
            if selectedForWhatButton == "For Sale"{
                delegate?.changeHomeTypeTableViewHeight(height: CGFloat(41 * (Double(homeType["residentialS"]!.count) / 2.0).rounded()))
                selectedTypeTitle = homeType["residentialS"]!.first!.name!
                return getAllTypeModels(data: homeType["residentialS"]!)
            }else{
                delegate?.changeHomeTypeTableViewHeight(height: CGFloat(41 * (Double(homeType["residentialR"]!.count) / 2.0).rounded()))
                selectedTypeTitle = homeType["residentialR"]!.first!.name!
                return getAllTypeModels(data: homeType["residentialR"]!)
            }
        }
        delegate?.changeHomeTypeTableViewHeight(height: CGFloat(41 * (Double(homeType[selectedSpecializationButton]!.count) / 2.0).rounded()))
        selectedTypeTitle = homeType[selectedSpecializationButton]!.first!.name!
        return getAllTypeModels(data: homeType[selectedSpecializationButton]!)
    }
    
    
    
    func getOtherFeatures()->[TypeModel]{
        if selectedSpecializationButton == "residential"{
            let selectedTypeText = selectedTypeTitle
            if selectedTypeText != "land"{
                if selectedTypeText == "floor" || selectedTypeText == "apartment"{
                    delegate?.changeOtherFeatureTableViewHeight(height: CGFloat(41 * (Double(otherFeatures["residentialA"]!.count) / 2.0)))
                    return getAllFeature(data: otherFeatures["residentialA"]!)
                }else{
                    delegate?.changeOtherFeatureTableViewHeight(height: CGFloat(41 * (Double(otherFeatures["residentialS"]!.count) / 2.0)))
                    return getAllFeature(data: otherFeatures["residentialS"]!)
                }
            }
        }
        delegate?.changeOtherFeatureTableViewHeight(height: CGFloat(41 * (Double(otherFeatures["residentialL"]!.count) / 2.0)))
        return getAllFeature(data: otherFeatures["residentialL"]!)
    }
    
    
    func getSelectedTypeTitle()->String{
        return selectedTypeTitle
    }
    
    func getSelectedForWhatButton()->String{
        return selectedForWhatButton
    }
    
    func setSelectedSpecializationButton(specialization:String){
        selectedSpecializationButton = specialization
        delegate?.reloadHomeTypesTableView()
    }
    
    func getSelectedSpecializationButton() ->String{
        return selectedSpecializationButton
    }
    
    func setSelectedForWhatButton(forWhat:String){
        selectedForWhatButton = forWhat
        delegate?.reloadHomeTypesTableView()
        delegate?.chooseViewToShow(selectedTypeTitle: selectedTypeTitle)
    }
    
    func appendToTypesButtons(button:UIButton){
        typesButtons.append(button)
    }
    
    func clearTypesButtons(){
        typesButtons.removeAll()
    }
    
    
    func selectType(title:String,id:Int,button:UIButton){
        selectedTypeTitle = title
        selectedButtonId = id
        for btn in typesButtons {
            if button == btn{
                button.isSelected = true
                selectedTypeButton = button
                continue
            }
            btn.isSelected = false
        }
        delegate?.chooseViewToShow(selectedTypeTitle: selectedTypeTitle)
        delegate?.reloadOtherFeaturesTableView()
    }
    
    
    func appendToFeaturesButtons(button:UIButton){
        featuresButtons.append(button)
    }
    
    func clearFeaturesButtons(){
        featuresButtons.removeAll()
    }
    
    func selectFeature(title:String,button:UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected{
            selectedFeatures.append(title)
        }else{
            selectedFeatures.removeAll { $0 == title }
        }
    }
    
    
    
    private func getAllTypeModels(data:[Categories]) -> [TypeModel]{
        var types = [TypeModel]()
        var index = 0
        while(index < data.count){
            var type:TypeModel!
            if index + 1 < data.count {
                type = TypeModel(firstTypeId:data[index].id ?? -1,firstTypeName: data[index].name ?? "", firstTypeIsSelected: false, isThereSecond: true,secondTypeId: data[index+1].id ?? -1,secondTypeName: data[index+1].name ?? "", secondTypeIsSelected: false)
            }else{
                type = TypeModel(firstTypeId:data[index].id ?? -1,firstTypeName: data[index].name ?? "", firstTypeIsSelected: false,isThereSecond: false,secondTypeId: -1,secondTypeName: "", secondTypeIsSelected: false)
            }
            types.append(type)
            index += 2
        }
        return types
    }
    
    
    private func getAllFeature(data:[String])->[TypeModel]{
        var features = [TypeModel]()
        var index = 0
        while(index < data.count){
            var feature:TypeModel!
            if index + 1 < data.count {
                feature = TypeModel(firstTypeName: data[index], firstTypeIsSelected: false, isThereSecond: true, secondTypeName: data[index+1] , secondTypeIsSelected: false)
            }else{
                feature = TypeModel(firstTypeName: data[index] , firstTypeIsSelected: false,isThereSecond: false,secondTypeName: "", secondTypeIsSelected: false)
            }
            features.append(feature)
            index += 2
        }
        return features
    }
    
    
    
    func switchSelectedButton(clickedButton:UIButton,buttons:[UIButton]){
        for button in buttons{
            if button == clickedButton{
                button.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                continue
            }
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1), for: .normal)
        }
    }
    
}
