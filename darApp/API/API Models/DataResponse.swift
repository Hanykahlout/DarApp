

import Foundation
import ObjectMapper

struct ResponseData : Mappable {
	var access_token : String?
	var token_type : String?
	var expires_at : String?
    var email : [String]?
    var password : [String]?
    var phone : [String]?
    var city : [String]?
    var region : [String]?
    var data : UserData?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		access_token <- map["access_token"]
		token_type <- map["token_type"]
		expires_at <- map["expires_at"]
		data <- map["data"]
        email <- map["email"]
        password <- map["password"]
        phone <- map["phone"]
        city <- map["city"]
        region <- map["region"]

	}

}


