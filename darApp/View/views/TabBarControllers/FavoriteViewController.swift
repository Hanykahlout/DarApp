//
//  FavoriteViewController.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit
import GoogleMaps
class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var FavoriteTableView: UITableView!
    @IBOutlet weak var pageStyleButton: UIButton!
    @IBOutlet weak var noFavoriteImage: UIImageView!
    @IBOutlet weak var createAccountView: UIView!
    @IBOutlet weak var mapView: UIView!
    private let presnter = FavoritePresnter()
    private var favorites = [FavoriteData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if UserDefaultsData.shard.isLoggedIn() {
            createAccountView.isHidden = true
            getFavoriteData()
        }else{
            createAccountView.isHidden = false
            FavoriteTableView.isHidden = true
            noFavoriteImage.isHidden = true
        }
    }
    
    
    private func initlization(){
        presnter.delegate = self
        setUpTableView()
        pageStyleButton.setImage(#imageLiteral(resourceName: "ico - 24 - map & places - map_outlined"), for: .normal)
    }
    
    private func getFavoriteData(){
        favorites = presnter.getFavoriteData()
        if favorites.isEmpty{
            noFavoriteImage.isHidden = false
            FavoriteTableView.isHidden = true
        }else{
            noFavoriteImage.isHidden = true
            FavoriteTableView.isHidden = false
        }
    }
    
    
    @IBAction func showingStyleAction(_ sender: UIButton) {
        if pageStyleButton.imageView!.image == #imageLiteral(resourceName: "ico - 24 - map & places - map_outlined"){
            FavoriteTableView.isHidden = true
            mapView.isHidden = false
            presnter.showGoogleMap()
            pageStyleButton.setImage(#imageLiteral(resourceName: "Icon awesome-list"), for: .normal)
        }else{
            FavoriteTableView.isHidden = false
            mapView.isHidden = true
            pageStyleButton.setImage(#imageLiteral(resourceName: "ico - 24 - map & places - map_outlined"), for: .normal)
        }
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}


extension FavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.setData(data: favorites[indexPath.row])
        return cell
    }
    
    
}


extension FavoriteViewController:FavoritePresnterDelegate{
    func getMyMapViewBounds() -> CGRect {
        return mapView.bounds
    }
    
    func addGoogleMapToMyMapView(googleMap: GMSMapView) {
        mapView.addSubview(googleMap)
    }
    
    
}
