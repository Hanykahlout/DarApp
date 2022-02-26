

import Foundation
import ObjectMapper

struct BaseResponseArray<T:Mappable> : Mappable {
    var status : Status?
    var data : [T]?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {

        status <- map["status"]
        data <- map["data"]
    }

}
