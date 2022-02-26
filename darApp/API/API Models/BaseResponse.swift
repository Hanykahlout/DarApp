

import Foundation
import ObjectMapper

struct BaseResponse<T:Mappable> : Mappable {
	var status : Status?
	var data : T?

	init?(map: Map) {

	}
    
	mutating func mapping(map: Map) {

		status <- map["status"]
		data <- map["data"]
	}

}
