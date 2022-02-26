//
//  FStorage.swift
//  darApp
//
//  Created by Hani Mac on 21/08/2021.
//

import UIKit
import Photos
import Firebase
import FirebaseStorage
import FirebaseStorageUI
import SVProgressHUD

class FStorage{
    public static var shard: FStorage = {
        let fStorage = FStorage()
        return fStorage
    }()
    private let firbaseStorage = Storage.storage().reference()
    typealias CallBack = (_ status:Bool) -> Void

    func uploadImage(profileName:String,uid:String,imageData:Data,callBack:@escaping(_ status:Bool,_ imageUrl:String) -> Void) {
        SVProgressHUD.show()

        firbaseStorage.child(profileName).child(uid).putData(imageData, metadata: nil) { (metaData, error) in
            if let _ = error{
                SVProgressHUD.dismiss()
                callBack(false,"")
                return
            }

            self.firbaseStorage.child(profileName).child(uid).downloadURL { (url, error) in
                SVProgressHUD.dismiss()
                if let _ = error{
                    callBack(false,"")
                    return
                }
                
                callBack(true,url?.absoluteString ?? "")
            }
        }
    }

}




