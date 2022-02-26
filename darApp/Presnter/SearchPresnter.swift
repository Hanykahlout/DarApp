//
//  SearchPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit


protocol SearchPresnterDelegate {
    
}

typealias SearchDelegate = SearchPresnterDelegate & UIViewController

class SearchPresnter: NSObject {
    weak var delegage:SearchDelegate?
    
    
    func getSearchResult(text:String)->[SearchResultInfo]{
        var results = [SearchResultInfo]()
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        results.append(.init(image: #imageLiteral(resourceName: "pexels-naim-benjelloun-2029694"), name: "Home", description: "uksahdksa laksdhja aklsjdh lakshd lajshd as kjhsd ", price: 200.0))
        return results
    }
}
