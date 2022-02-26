//
//  NearMeViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit
import GoogleMaps
class NearMeViewController: UIViewController {

    @IBOutlet weak var mapView: UIView!
    private let presnter = NearMePresnter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presnter.checkLocation()
        presnter.showGoogleMap(location: CLLocationCoordinate2D(latitude: 53.958332, longitude: -1.080278))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }

    
    private func initlization(){
        presnter.delegate = self
        
    }
    
    @IBAction func listAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func locationAction(_ sender: Any) {
        presnter.showGoogleMapWithCurrentLocation()
    }

}

extension NearMeViewController:NearMePresnterDelegate{
    func getMapViewBounds() -> CGRect {
        return mapView.bounds
    }
    
    func addGoogleMapToMyMapView(googleMap: GMSMapView) {
        mapView.addSubview(googleMap)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
