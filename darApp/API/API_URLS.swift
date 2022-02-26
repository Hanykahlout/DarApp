//
//  API_URLS.swift
//  darApp
//
//  Created by Hani Mac on 12/08/2021.
//

import Foundation


public enum API_URLs : String {
    
    case Base_URL = "https://darak-sa.com/api/"
    
   
    
    case Register = "auth/signup"
    case Login = "auth/login"
    case Update = "user/update"
    case Social_Login = "auth/social"
    case Get_Date_On_SignUp = "auth/sign/data"
    case Get_Date_From_Of_User = "user"
    
    case Rest_Password = "auth/reset"
    case Check_Code_It_True = "auth/checkCode"
    case Change_Password_After_Check_Code = "auth/resetPassword"
    
    case Add_Favorite = "addFavorite/{id}"
    case Delete_Favorite = "delFavorite"
    case Get_Favorite = "favorite"
    case Setting = "setting/data"
    case Home_Map_Copy = "home/{id1}/{id2}/{id3}/{id4}"
    case Home_Fillter = "home/filter?masterType={id}&"
    case Home_FillterWithPrice = "home/filter?masterType={id1}&price[from]={id2}&price[to]={id3}"
    case Master_Fillter = "filter?masterType={id1}&type={id2}&price[from]={id3}&price[to]={id4}&space[from]={id5}&space[to]={id6}&bedroom={id7}&living_room={id8}&bathrooms={id9}&floor={id10}&state_age={id11}&kitchen={id12}&driver_room={id13}&furniture={id14}&conditioners={id15}&service_room={id16}&rooftop={id17}&maid_room={id18}&coming_soon={id19}&electricity={id20}&internet={id21}&water={id22}&furnished={id23}&sewage={id24}"
    case Owner = "owner/{id}"
    case Google = "sign/google?={id1}&data={id2}"
    case Esate = "estate/{id}"
    case Esate_Copy = "estate/ios/{id}"
    
    case Get_Notification = "notification"
    case Get_Category = "category"
    case Search = "search"
    case Rate = "rate"
    case Report_Estate = "report"
    case Request_Visit = "request/visit"
    case Send_Bids = "request/bid"
    
    var url :String {
        switch self {
        case .Base_URL:
            return API_URLs.Base_URL.rawValue
        default:
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue)"
        }
    }
    
    
    func withOneToFourIDs(id1:String,id2:String,id3:String,id4:String) -> String{
        switch self {
        case .Add_Favorite , .Owner , .Esate , .Esate_Copy, .Home_Fillter:
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "{id}", with: "\(id1)"))"
        case .Google :
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "={id1}&data={id2}", with: "=\(id1)&data=\(id2)"))"
        case .Home_FillterWithPrice :
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "{id1}&price[from]={id2}&price[to]={id3}", with: "\(id1)&price[from]=\(id2)&price[to]=\(id3)"))"
        case .Home_Map_Copy :
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "{id1}/{id2}/{id3}/{id4}", with: "\(id1)/\(id2)/\(id3)/\(id4)"))"
        default:
            return ""
        }
    }
    
    
    func with24IDs(arr21IDs:[String]) -> String{
        switch self {
        case .Master_Fillter :
            return "\(API_URLs.Base_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "{id1}&type={id2}&price[from]={id3}&price[to]={id4}&space[from]={id5}&space[to]={id6}&bedroom={id7}&living_room={id8}&bathrooms={id9}&floor={id10}&state_age={id11}&kitchen={id12}&driver_room={id13}&furniture={id14}&conditioners={id15}&service_room={id16}&rooftop={id17}&maid_room={id18}&coming_soon={id19}&electricity={id20}&internet={id21}&water={id22}&furnished={id23}&sewage={id24}", with: "\(arr21IDs[0])&type=\(arr21IDs[1])&price[from]=\(arr21IDs[2])&price[to]=\(arr21IDs[3])&space[from]=\(arr21IDs[4])&space[to]=\(arr21IDs[5])&bedroom=\(arr21IDs[6])&living_room=\(arr21IDs[7])&bathrooms=\(arr21IDs[8])&floor=\(arr21IDs[9])&state_age=\(arr21IDs[10])}&kitchen=\(arr21IDs[11])&driver_room=\(arr21IDs[12])&furniture=\(arr21IDs[13])&conditioners=\(arr21IDs[14])&rooftop=\(arr21IDs[15])&maid_room=\(arr21IDs[16])&electricity=\(arr21IDs[17])&internet=\(arr21IDs[18])&water=\(arr21IDs[19])&sewage=\(arr21IDs[20]))"))"
        default:
            return ""
        }
    }
    
}
