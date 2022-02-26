//
//  FFirestore.swift
//  darApp
//
//  Created by Hani Mac on 21/08/2021.
//


import UIKit
import FirebaseFirestore
import SVProgressHUD
class FFirestore{

    public static var shard: FFirestore = {
        let fFirestore = FFirestore()
        return fFirestore
    }()
    private let firestore  = Firestore.firestore()

    func savePersonalImageURL(userID:String,personalImageURL:String,callBack:@escaping (_ status:Bool) -> Void){
        firestore.collection("ImagesURLs").document(userID).setData(["personalIMG":personalImageURL],merge: true) { error in
            if let _ = error{
                callBack(false)
                return
            }
            callBack(true)
        }
    }
    
    func saveBGImageURL(userID:String,BGImageURL:String,callBack:@escaping (_ status:Bool) -> Void){
        firestore.collection("ImagesURLs").document(userID).setData(["BGIMG":BGImageURL],merge: true) { error in
            if let _ = error{
                callBack(false)
                return
            }
            callBack(true)
        }
    }
    
    func getImageUrl(userID:String,imageType:ImageType,callBack:@escaping(_ status:Bool,_ url:String)->Void){
        firestore.collection("ImagesURLs").document(userID).getDocument { snapshots, error in
            if let _ = error{
                callBack(false,"")
                return
            }
            callBack(true,snapshots!.data()![imageType.rawValue] as! String)
        }
    }
    
    
}

enum ImageType:String {
    case personal = "personalIMG"
    case BG = "BGIMG"
}


