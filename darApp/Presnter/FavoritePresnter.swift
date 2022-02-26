//
//  FavoritePresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit
import GoogleMaps
protocol FavoritePresnterDelegate {
    func getMyMapViewBounds()->CGRect
    func addGoogleMapToMyMapView(googleMap:GMSMapView)
}

typealias FavoriteDelegate = FavoritePresnterDelegate & UIViewController

class FavoritePresnter: NSObject {
    weak var delegate:FavoriteDelegate?
    private var googleMap = GMSMapView()
    
    func getFavoriteData()->[FavoriteData]{
        var favorites = [FavoriteData]()
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        favorites.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-1396132"), address: "Palestine Gaza Street 00970", price: 70.000, type: "condo for sale", category: "Residential and commercial"))
        return favorites
    }
    
    
    public func showGoogleMap(){
        let coordinate = CLLocationCoordinate2D(latitude: 53.958332, longitude: -1.080278)
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6)
        googleMap.camera = camera
        googleMap.frame = delegate!.getMyMapViewBounds()
        delegate?.addGoogleMapToMyMapView(googleMap: googleMap)
        addMarkersToMap()
    }
    
    private func addMarkersToMap(){
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 53.958332, longitude: -1.080278)
        marker1.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 52.192001, longitude: -2.220000)
        marker2.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 51.063202, longitude: -1.308000)
        marker3.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: 51.209000, longitude: -2.647000)
        marker4.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        let marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2D(latitude: 53.680000, longitude: -1.490000)
        marker5.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        
        let marker6 = GMSMarker()
        marker6.position = CLLocationCoordinate2D(latitude: 50.259998, longitude: -5.051000)
        marker6.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        
        let marker7 = GMSMarker()
        marker7.position = CLLocationCoordinate2D(latitude: 54.906101, longitude: -1.381130)
        marker7.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112112"))
        
        let marker8 = GMSMarker()
        marker8.position = CLLocationCoordinate2D(latitude: 53.383331, longitude: -1.466667)
        marker8.iconView = UIImageView(image: #imageLiteral(resourceName: "Group 112037"))
        
        marker1.map = googleMap
        marker2.map = googleMap
        marker3.map = googleMap
        marker4.map = googleMap
        marker5.map = googleMap
        marker6.map = googleMap
        marker7.map = googleMap
        marker8.map = googleMap
        
    }
}
