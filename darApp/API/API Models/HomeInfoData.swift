

import Foundation
import ObjectMapper

struct HomeInfoData : Mappable {
	var ads : Ads?
	var similar : [Estate]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		ads <- map["ads"]
		similar <- map["similar"]
	}

}
