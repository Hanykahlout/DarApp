

import Foundation
import ObjectMapper

struct Status : Mappable {
	var code : String?
	var status : String?
	var message : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		code <- map["code"]
		status <- map["status"]
		message <- map["message"]
	}

}
