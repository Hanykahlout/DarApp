//
//  TeamsAboutPrivacyPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit

protocol TeamsAboutPrivacyPresnterDelegate {
    func setHeaderWithContent(content:String)
}

typealias TeamsAboutPrivacyDelegate = TeamsAboutPrivacyPresnterDelegate & UIViewController


class TeamsAboutPrivacyPresnter:NSObject{
    weak var delegate:TeamsAboutPrivacyDelegate?
    
    
    func getContent(){
        let content = "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsumsimply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
        delegate?.setHeaderWithContent(content:content)
    }
    
}


enum ScreenType:String {
    case TermsOfUser = "Terms Of User"
    case PrivacyPolicy = "Privacy Policy"
    case AboutDar = "About Dar"
}
