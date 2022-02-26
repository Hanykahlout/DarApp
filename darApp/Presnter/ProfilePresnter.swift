//
//  ProfilePresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit


protocol ProfilePresnterDelegate {
    func showAlert(title:String,message:String)
}

typealias ProfileDelegate = ProfilePresnterDelegate & UIViewController


class ProfilePresnter: NSObject {
    weak var delegate:ProfileDelegate?
    
    
    func updateRating(id:Int,rate:Double){
        APIController.shard.updateRate(ownerId: id, rate: rate) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Success", message: message)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func getActivitesData()->[ActiviteInfo]{
        var activitiesData = [ActiviteInfo]()
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        activitiesData.append(.init(title: "Home", image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), description: "simply dummy text of the printing "))
        return activitiesData
    }
    
    
}
