//
//  HomePresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit

protocol HomePresenterDelegate {
    func updateFactCollectionViewHeight(factCount:Int)
    func setDateInDateLabel(date:String)
    func showAlert(title:String,message:String)
    func setAllData(data:HomeInfoData)
    func changeSelectionFavoritButton(to: Bool)
    func hideVisitRequestView()
}

typealias HomeDelegate = HomePresenterDelegate & UIViewController

class HomePresnter:NSObject{
    
    weak var delegate: HomeDelegate?
    private var ads:Ads?
    private var similar:[Estate]?
    
    func getImages()->[String]{
        return ads?.img ?? []
    }
    
    func getFactData() -> [FactData]{
        if let ads = ads {
            var factsFeaturesData = [FactData]()
            var allFacts = [String:String?]()
            allFacts["Floor"] = ads.floor_Number
            allFacts["Rooms"] = "\(ads.rooms ?? -1)"
            allFacts["Interface"] = ads.interface
            allFacts["Bathroom"] = "\(ads.bathroom ?? -1)"
            allFacts["Area"] = "\(ads.area ?? -1)"
            allFacts["Days"] = ads.days_offer
            allFacts["Rent"] = ads.typeOfRent
            allFacts["Age"] = "\(ads.age ?? -1)"
            allFacts["Kitchen"] = ads.kitchen
            allFacts["Roof"] = ads.roof_top
            allFacts["Conditioner"] = ads.conditioner
            allFacts["Furnished"] = ads.furnished
            allFacts["Cellar"] = ads.cellar
            allFacts["Special"] = ads.special_parking
            allFacts["masheb"] = ads.masheb
            allFacts["Private"] = ads.private_entrance
            allFacts["Street"] = "\(ads.street_width ?? -1)"
            allFacts["Living"] = "\(ads.living_Room ?? -1)"
            allFacts["villa_type"] = ads.villa_type
            allFacts["Internal"] = ads.internal_staircase
            allFacts["Pool"] = ads.pool
            allFacts["Driver"] = ads.driver_Room
            allFacts["Maids"] = ads.maids_Room
            allFacts["Price_meter"] = ads.price_meter
            allFacts["Boards"] = ads.boards
            allFacts["Tent"] = ads.tent
            allFacts["Flats"] = ads.flats
            allFacts["Stores"] = ads.stores
            allFacts["Building_type"] = ads.building_type
            allFacts["coming_soon"] = "\(ads.coming_soon ?? -1)"
            allFacts["Electrical_warranty"] = ads.electrical_warranty
            allFacts["building_code"] = ads.building_code
            allFacts["Construction_guarantee"] = ads.construction_guarantee
            allFacts["Plumbing_warranty"] = ads.plumbing_warranty
            allFacts["Uncommon_land"] = ads.uncommon_land
            allFacts["electronic_instrument"] = ads.electronic_instrument
            allFacts["mortgaged"] = ads.mortgaged
            
            for (key,value) in allFacts {
                if let value = value, value != "-1"{
                    factsFeaturesData.append(.init(title: key, value: value))
                }
            }
            
            delegate?.updateFactCollectionViewHeight(factCount: factsFeaturesData.count)
            return factsFeaturesData
        }
        return []
    }
    
    func getTimeData()-> [String] {
        var timesData = [String]()
        timesData.append("19:00")
        timesData.append("18:00")
        timesData.append("17:00")
        timesData.append("16:00")
        timesData.append("15:00")
        timesData.append("14:00")
        timesData.append("13:00")
        timesData.append("12:00")
        timesData.append("11:00")
        timesData.append("10:00")
        timesData.append("9:00")
        timesData.append("8:00")
        timesData.append("7:00")
        return timesData
    }
    
    
    func getSimilarData()->[SimilarData]{
        if let similar = similar {
            var similarData = [SimilarData]()
            
            for estate in similar{
                similarData.append(.init(id: estate.id ?? -1,image: estate.img ?? "", title: estate.name ?? "", description: estate.address ?? "", price: estate.price ?? 0))
            }
            
            return similarData
        }
        return []
    }
    
    
    func getDateString(date:Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        let selectedDate = dateFormatter.string(from: date)
        let currentDate = dateFormatter.string(from: Date())
        if selectedDate == currentDate{
            dateFormatter.dateFormat = ", MMMM dd"
            delegate?.setDateInDateLabel(date: "Today\(dateFormatter.string(from: date))")
        }else{
            delegate?.setDateInDateLabel(date: dateFormatter.string(from: date))
        }
    }
    
    
    func getEstateData(by id:String){
        APIController.shard.getHomeData(by: id) { status, message, data in
            if status == "true"{
                if let data = data{
                    self.ads = data.ads!
                    self.similar = data.similar
                    self.delegate?.setAllData(data: data)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func addToFavorit(by id:Int){
        
        APIController.shard.addToFavorit(by: String(id)) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.changeSelectionFavoritButton(to: true)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func deleteFromFavorit(by id:Int){
        APIController.shard.deleteFromFavorit(by: String(id)) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.changeSelectionFavoritButton(to: false)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    func makeVisitRequest(id:Int,date:Date,time:String,phone:String,message:String){
        let _id = String(id)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let _date = dateFormatter.string(from: date)
        print("Date::::: \(_date)")
        APIController.shard.visitRequest(id: _id, date: _date, time: time, phone: phone, message: message) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.hideVisitRequestView()
                    self.delegate?.showAlert(title: "Success", message: message)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }

    
}














