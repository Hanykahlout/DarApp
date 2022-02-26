
import Foundation
import ObjectMapper

class UserData : Mappable {
	var id : Int?
	var name : String?
	var img : String?
	var bio : String?
	var address : String?
	var phone : String?
	var email : String?
    
    
    required init?(map: Map) {

	}
    
    init(id:Int,name:String,img:String,bio:String,address:String,phone:String,email:String){
        self.id = id
        self.name = name
        self.img = img
        self.bio = bio
        self.address = address
        self.phone = phone
        self.email = email
    }
    
    
    func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		img <- map["img"]
		bio <- map["bio"]
		address <- map["address"]
		phone <- map["phone"]
		email <- map["email"]
	}

}
