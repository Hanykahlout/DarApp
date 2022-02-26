/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Ads : Mappable {
	var id : Int?
	var name : String?
	var description : String?
	var address : String?
	var creted_at : String?
	var img : [String]?
	var price : Int?
	var priceText : String?
	var advertiser_type : String?
	var type : String?
	var type_id : Int?
	var type_Estate_text : String?
	var lat : String?
	var lng : String?
	var is_favourite : Bool?
	var owner_id : Int?
	var owner_name : String?
	var owner_bio : String?
	var owner_img : String?
	var owner_rate : Int?
	var typeOfRent : String?
	var owner_phone : String?
	var view : Int?
	var floor_Number : String?
	var rooms : Int?
	var interface : String?
	var bathroom : Int?
	var area : Int?
	var days_offer : String?
	var rent_duration : String?
	var age : Int?
	var kitchen : String?
	var roof_top : String?
	var conditioner : String?
	var furnished : String?
	var cellar : String?
	var rent_contract : String?
	var special_parking : String?
	var masheb : String?
	var private_entrance : String?
	var street_width : Int?
	var living_Room : Int?
	var villa_type : String?
	var internal_staircase : String?
	var pool : String?
	var driver_Room : String?
	var maids_Room : String?
	var price_meter : String?
	var boards : String?
	var tent : String?
	var flats : String?
	var stores : String?
	var building_type : String?
	var coming_soon : Int?
	var electrical_warranty : String?
	var building_code : String?
	var construction_guarantee : String?
	var plumbing_warranty : String?
	var uncommon_land : String?
	var electronic_instrument : String?
	var mortgaged : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		address <- map["address"]
		creted_at <- map["creted_at"]
		img <- map["img"]
		price <- map["price"]
		priceText <- map["priceText"]
		advertiser_type <- map["Advertiser_type"]
		type <- map["type"]
		type_id <- map["type_id"]
		type_Estate_text <- map["type_Estate_text"]
		lat <- map["lat"]
		lng <- map["lng"]
		is_favourite <- map["is_favourite"]
		owner_id <- map["owner_id"]
		owner_name <- map["owner_name"]
		owner_bio <- map["owner_bio"]
		owner_img <- map["owner_img"]
		owner_rate <- map["owner_rate"]
		typeOfRent <- map["typeOfRent"]
		owner_phone <- map["owner_phone"]
		view <- map["View"]
		floor_Number <- map["Floor Number"]
		rooms <- map["Rooms"]
		interface <- map["Interface"]
		bathroom <- map["Bathroom"]
		area <- map["Area"]
		days_offer <- map["Days offer"]
		rent_duration <- map["Rent duration"]
		age <- map["Age"]
		kitchen <- map["Kitchen"]
		roof_top <- map["Roof top"]
		conditioner <- map["Conditioner"]
		furnished <- map["Furnished"]
		cellar <- map["Cellar"]
		rent_contract <- map["Rent contract"]
		special_parking <- map["Special parking"]
		masheb <- map["masheb"]
		private_entrance <- map["Private entrance"]
		street_width <- map["Street width"]
		living_Room <- map["Living Room"]
		villa_type <- map["villa_type"]
		internal_staircase <- map["Internal staircase"]
		pool <- map["Pool"]
		driver_Room <- map["Driver Room"]
		maids_Room <- map["Maids Room"]
		price_meter <- map["Price_meter"]
		boards <- map["Boards"]
		tent <- map["Tent"]
		flats <- map["Flats"]
		stores <- map["Stores"]
		building_type <- map["Building_type"]
		coming_soon <- map["coming_soon"]
		electrical_warranty <- map["Electrical_warranty"]
		building_code <- map["building_code"]
		construction_guarantee <- map["Construction_guarantee"]
		plumbing_warranty <- map["Plumbing_warranty"]
		uncommon_land <- map["Uncommon_land"]
		electronic_instrument <- map["electronic_instrument"]
		mortgaged <- map["mortgaged"]
	}

}
