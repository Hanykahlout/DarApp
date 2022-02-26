//
//  NearMePresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit
import GoogleMaps
protocol NearMePresnterDelegate {
    func showAlert(title:String,message:String)
    func getMapViewBounds()->CGRect
    func addGoogleMapToMyMapView(googleMap:GMSMapView)
}

typealias NearMeDelegate = NearMePresnterDelegate & UIViewController

class NearMePresnter: NSObject{
    weak var delegate:NearMeDelegate?
    private var loctionManager = CLLocationManager()
    public var currentLocation:CLLocationCoordinate2D?
    private var googleMap = GMSMapView()
    
    func checkLocation(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            loctionManager.requestWhenInUseAuthorization()
            loctionManager.startUpdatingLocation()
        }else{
            delegate?.showAlert(title: "Error", message: "You Have To Enable Location From Settings To Allow Us Get Your Location")
        }
    }
    
    private func setupLocationManager() {
        loctionManager.delegate = self
        loctionManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showGoogleMap(location:CLLocationCoordinate2D){
        googleMap.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 6)
        googleMap.frame = delegate!.getMapViewBounds()
        delegate?.addGoogleMapToMyMapView(googleMap: googleMap)
        getMarkers()
    }
    
    func showGoogleMapWithCurrentLocation(){
        if let currentLocation = currentLocation{
            showGoogleMap(location: currentLocation)
        }else{
            delegate?.showAlert(title: "Error", message: "You Have To Enable Location For This App")
        }
    }
    
    private func getMarkers(){
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: 53.958332, longitude: -1.080278)
        marker1.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 52.192001, longitude: -2.220000)
        marker2.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 51.063202, longitude: -1.308000)
        marker3.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        
        let marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2D(latitude: 51.209000, longitude: -2.647000)
        marker4.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        let marker5 = GMSMarker()
        marker5.position = CLLocationCoordinate2D(latitude: 53.680000, longitude: -1.490000)
        marker5.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        
        let marker6 = GMSMarker()
        marker6.position = CLLocationCoordinate2D(latitude: 50.259998, longitude: -5.051000)
        marker6.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        
        let marker7 = GMSMarker()
        marker7.position = CLLocationCoordinate2D(latitude: 54.906101, longitude: -1.381130)
        marker7.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
        let marker8 = GMSMarker()
        marker8.position = CLLocationCoordinate2D(latitude: 53.383331, longitude: -1.466667)
        marker8.iconView = UIImageView(image: #imageLiteral(resourceName: "ico - 24 - map & places - poi"))
        
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

extension NearMePresnter:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        currentLocation = location.coordinate
    }
}
