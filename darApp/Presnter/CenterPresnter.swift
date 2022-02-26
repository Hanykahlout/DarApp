//
//  CenterPresnter.swift
//  darApp
//
//  Created by Hani Mac on 14/08/2021.
//

import UIKit
import GoogleMaps
protocol CenterPresnterDelegate {
    func getMyMapViewBounds()->CGRect
    func addGoogleMapToMyMapView(googleMap:GMSMapView)
    func tableViewReload()
    func didTapMarker()
    func didTapAt()
    func showAlertAction(title:String,message:String)
    func getSpace() -> Int
    func getType() -> String
    func getEstateCardData(estate:Estate)
    func changeSelectionFavoritButton(to:Bool)
    func getAllTypes()
    
}

typealias CenterDelegate = CenterPresnterDelegate & UIViewController

class CenterPresnter: NSObject{
    
    weak var delegate:CenterDelegate?
    
    private let locationManager = CLLocationManager()
    private let googleMap = GMSMapView()
    private var currentLocation:CLLocationCoordinate2D?
    private var isFirstTime = true
    private var homeData:Home_Google_Data?
    private var allSelectedType = [Int]()
    
    
    func getAllCategories() -> [TypeModel]?{
        if let homeData = homeData , let categories = homeData.categories{
            var types = [TypeModel]()
            var index = 0
            while(index < categories.count){
                var type:TypeModel!
                if index + 1 < categories.count {
                    type = TypeModel(firstTypeId:categories[index].id ?? -1,firstTypeName: categories[index].name ?? "", firstTypeIsSelected: false, isThereSecond: true,secondTypeId: categories[index+1].id ?? -1,secondTypeName: categories[index+1].name ?? "", secondTypeIsSelected: false)
                }else{
                    type = TypeModel(firstTypeId:categories[index].id ?? -1,firstTypeName: categories[index].name ?? "", firstTypeIsSelected: false,isThereSecond: false,secondTypeId: -1,secondTypeName: "", secondTypeIsSelected: false)
                }
                types.append(type)
                index += 2
            }
            return types
        }
        return nil
    }
    
    
    func checkLocationEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            if let currentLocation = currentLocation {
                showGoogleMap(withCoordinate: currentLocation)
            }
        }
    }
    
    private func setupLocationManager() {
        googleMap.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func showGoogleMap(withCoordinate coordinate :CLLocationCoordinate2D?) {
        if let coordinate = coordinate{
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 9)
            googleMap.camera = camera
        }
        
        googleMap.frame = delegate!.getMyMapViewBounds()
        delegate?.addGoogleMapToMyMapView(googleMap: googleMap)
    }
    
    
    private func addMarkersToMap(estate:[Estate]){
        googleMap.clear()
        for item in estate{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(item.lat!)!, longitude: Double(item.lng!)!)
            marker.iconView = UIImageView(image: imageWithImage(image: #imageLiteral(resourceName: "Group 112112"), scaledToSize: CGSize(width: 80, height: 55)))
            marker.map = googleMap
        }
    }
    
    
    private func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func getData() -> [Dar]{
        var data = [Dar]()
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        data.append(.init(image: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"), price: 100000, address: "Damam , Rimal", daysDescription: "3 bath | 4 Room | 2 hole", type: "Home For sale ", isFavorate: true))
        delegate?.tableViewReload()
        return data
    }
    
    func changeBGColor(for button:UIButton,buttons:[UIButton]){
        for btn in buttons {
            if btn == button{
                button.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1)
                button.setTitleColor(.white, for: .normal)
            }else{
                btn.backgroundColor = .clear
                btn.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1), for: .normal)
            }
        }
    }

    func addToSelectedTypes(id:Int){
        allSelectedType.append(id)
    }
    
    func deleteFromSelectedType(id:Int){
        allSelectedType.removeAll { $0 == id }
    }
    
    func clearAllSelectedTypes(){
        allSelectedType.removeAll()
    }
    
    
    func getMapData(space:Int,type:String){
        if let currentLocation = currentLocation {
            let _type = type == "For Sale" ? "1" : "2"
            let _lat = String(currentLocation.latitude)
            let _lng = String(currentLocation.longitude)
            let _space = String(space)
            APIController.shard.getMapData(lat: _lat, lng: _lng, space: _space, type: _type) { status, message, data in
                if status == "true"{
                    if let data = data,let estate = data.estate{
                        self.homeData = data
                        DispatchQueue.main.async {
                            self.delegate?.getAllTypes()
                        }
                        self.addMarkersToMap(estate: estate)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.delegate?.showAlertAction(title: "Error", message: message)
                    }
                }
            }
        }else{
            delegate?.showAlertAction(title: "Error", message: "Your location is not specified yet")
        }
    }
    
    
    func showGoogleMapInCurrentLocation(){
        if let location = currentLocation{
            showGoogleMap(withCoordinate: location)
        }else{
            delegate?.showAlertAction(title: "Error", message: "Your location is not specified yet")
        }
    }
    
    
    func typesFillterAction(type:String){
        APIController.shard.fillterEstate(by: allSelectedType,type: type) { status, message, data in
            if status == "true"{
                if let data = data{
                    DispatchQueue.main.async {
                        self.homeData!.estate = data
                        self.addMarkersToMap(estate: data)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func priceFilterAction(type:String,priceFrom:String,priceTo:String){
        APIController.shard.fillterEstate(priceFrom: priceFrom, priceTo: priceTo, type: type) { status, message, data in
            if status == "true"{
                if let data = data{
                    DispatchQueue.main.async {
                        self.homeData!.estate = data
                        self.addMarkersToMap(estate: data)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
    
}


extension CenterPresnter:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        delegate?.didTapAt()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        delegate?.didTapMarker()
        let estate = showEstateCard(lat: marker.position.latitude, lng: marker.position.longitude)
        if let estate = estate{
            delegate?.getEstateCardData(estate: estate)
        }
        return true
    }
    
    private func showEstateCard(lat:Double,lng:Double) -> Estate?{
        if let homeData = homeData {
            for item in homeData.estate!{
                if lat == Double(item.lat!)! && lng == Double(item.lng!)!{
                    return item
                }
            }
        }
        return nil
    }
    
    func addToFavorit(by id:Int){
        
        APIController.shard.addToFavorit(by: String(id)) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.changeSelectionFavoritButton(to: true)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
    
    
    func deleteFromFavorit(by id:Int){
        APIController.shard.deleteFromFavorit(by: String(id)) { status, message in
            if status == "true"{
                DispatchQueue.main.async {
                    self.delegate?.changeSelectionFavoritButton(to: false)
                }
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showAlertAction(title: "Error", message: message)
                }
            }
        }
    }
    
}


extension CenterPresnter:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location.coordinate
        if isFirstTime {
            showGoogleMapInCurrentLocation()
            let space = delegate!.getSpace()
            let type = delegate!.getType()
            getMapData(space: space, type: type)
            isFirstTime = false
        }
    }
}

