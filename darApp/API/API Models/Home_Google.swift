
import Foundation
import ObjectMapper

struct Home_Google_Data : Mappable {
	var estate : [Estate]?
	var categories : [Categories]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		estate <- map["estate"]
		categories <- map["categories"]
	}

}
