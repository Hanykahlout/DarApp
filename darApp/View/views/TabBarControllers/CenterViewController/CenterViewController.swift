//
//  HomeViewController.swift
//  darApp
//
//  Created by Hani Mac on 25/07/2021.
//

import UIKit
import GoogleMaps
import RangeSeekSlider

class CenterViewController: UIViewController {
    
    @IBOutlet weak var typesTableViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var typesViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var fillterOptionsView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var handButton: UIButton!
    @IBOutlet weak var serachTextField: UITextField!
    @IBOutlet var forWhatButtons: [UIButton]!
    private var selectedForWhatButton = "For Sale"
    @IBOutlet var fillterButtons: [UIButton]!
    @IBOutlet weak var darsTableView: UITableView!
    @IBOutlet weak var favorateButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceRangeSlider: RangeSeekSlider!
    @IBOutlet weak var createdAtLabel: UILabel!
    private var data = [Dar]()
    private var types = [TypeModel]()
    private let presnter = CenterPresnter()
    
    
    private var id:Int?
    public var isMap:Bool = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        cardView.isHidden = true
        presnter.checkLocationEnabled()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    private func initlization(){
        forWhatButtons[0].backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1)
        forWhatButtons[0].setTitleColor(.white, for: .normal)
        presnter.delegate = self
        
        xButton.isHidden = true
        
        serachTextField.delegate = self
        
        addGestureRecognizerToViews()
        
        setUpTableView()
        
        data = presnter.getData()
        
        presnter.showGoogleMap(withCoordinate: nil)
    }
    
    
    private func addGestureRecognizerToViews(){
        shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideFilterView)))
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(homeAction)))
    }
    
    
    @objc private func hideFilterView(){
        priceView.isHidden = true
        typeView.isHidden = true
        shadowView.isHidden = true
    }
    
    
    @objc private func homeAction(){
        if let id = id{
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.id = id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    private func clearTableViewAndSelectedTypes(){
        for index in 0..<types.count {
            types[index].firstTypeIsSelected = false
            types[index].secondTypeIsSelected = false
        }
        typesTableView.reloadData()
        presnter.clearAllSelectedTypes()
    }
    
    
    
    @IBAction func clearAction(_ sender: Any) {
        clearTableViewAndSelectedTypes()
    }
    
    @IBAction func priceFilterApply(_ sender: Any) {
        let from = priceRangeSlider.selectedMinValue * 1000
        let to = priceRangeSlider.selectedMaxValue * 1000
        presnter.priceFilterAction(type: selectedForWhatButton == "For Sale" ? "1" : "2", priceFrom: from.description, priceTo: to.description)
        hideFilterView()
    }
    
    @IBAction func applyAction(_ sender: Any) {
        presnter.typesFillterAction(type: selectedForWhatButton == "For Sale" ? "1" : "2")
        hideFilterView()
        clearTableViewAndSelectedTypes()
    }
    
    
    @IBAction func currentLocationAction(_ sender: Any) {
        presnter.showGoogleMapInCurrentLocation()
    }
    
    
    @IBAction func xAction(_ sender: Any) {
        serachTextField.text = ""
    }
    
    @IBAction func searchAction(_ sender: Any) {
        searchEntered()
    }
    
    @IBAction func fillterAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FillterViewController") as! FillterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func forSaleAction(_ sender: UIButton) {
        selectedForWhatButton = sender.titleLabel!.text!
        presnter.changeBGColor(for: sender,buttons: forWhatButtons)
        presnter.getMapData(space: getSpace(), type: getType())
    }
    
    @IBAction func forRentAction(_ sender: UIButton) {
        selectedForWhatButton = sender.titleLabel!.text!
        presnter.changeBGColor(for: sender,buttons: forWhatButtons)
        presnter.getMapData(space: getSpace(), type: getType())
    }
    
    @IBAction func  typeAction(_ sender: UIButton) {
        presnter.changeBGColor(for: sender,buttons: fillterButtons)
        shadowView.isHidden = false
        typeView.isHidden = false
    }
    
    
    @IBAction func priceAction(_ sender: UIButton) {
        shadowView.isHidden = false
        priceView.isHidden = false
        presnter.changeBGColor(for: sender,buttons: fillterButtons)
    }
    
    
    @IBAction func handAction(_ sender: Any) {
        
    }
    
    @IBAction func favoritAction(_ sender: Any) {
        if favorateButton.isSelected{
            presnter.deleteFromFavorit(by: id ?? -1)
        }else{
            presnter.addToFavorit(by: id ?? -1)
        }
    }
    
    
}

extension CenterViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        darsTableView.delegate = self
        darsTableView.dataSource = self
        
        typesTableView.delegate = self
        typesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == typesTableView{
            return types.count
        }
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == typesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell", for: indexPath) as! TypeTableViewCell
            cell.setData(data: types[indexPath.row])
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if darsTableView == tableView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension CenterViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchEntered()
        textField.text = ""
        textField.endEditing(true)
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        xButton.isHidden = false
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        xButton.isHidden = true
    }
    
    
    private func searchEntered(){
        if !serachTextField.text!.isEmpty{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            vc.searchText = serachTextField.text
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Empty Search Field!!", preferredStyle: .alert)
            alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}


extension CenterViewController:CenterPresnterDelegate{
    
    func getAllTypes() {
        if let types = presnter.getAllCategories(){
            self.types = types
            typesTableView.reloadData()
        }
        let typesHeight = CGFloat(types.count * 41)
        typesTableViewHeightConstrant.constant = typesHeight
        typesViewHeightConstrant.constant = 10 + typesHeight + 15 + 36 + 10
    }
    
    
    func changeSelectionFavoritButton(to: Bool) {
        favorateButton.isSelected = to
    }

    
    func getEstateCardData(estate: Estate) {
        id = estate.id
        cardImageView.sd_setImage(with: URL(string: estate.img!), placeholderImage: #imageLiteral(resourceName: "pexels-binyamin-mellish-186077"))
        priceLabel.text = "$\(estate.price!)"
        addressLabel.text = estate.address ?? ""
        typeLabel.text = estate.type ?? ""
        createdAtLabel.text = estate.creted_at ?? ""
        favorateButton.isSelected = estate.is_favourite ?? false
    }
    
    
    func getSpace() -> Int {
        return 11500
    }
    
    
    func getType() -> String {
        return selectedForWhatButton
    }
    
    
    func didTapMarker() {
        serachTextField.endEditing(true)
        cardView.isHidden = false
    }
    
    
    func didTapAt() {
        serachTextField.endEditing(true)
        cardView.isHidden = true
    }
    
    
    func tableViewReload() {
        darsTableView.reloadData()
    }
    
    
    func getMyMapViewBounds() -> CGRect {
        return mapView.bounds
    }
    
    
    func addGoogleMapToMyMapView(googleMap: GMSMapView) {
        mapView.addSubview(googleMap)
    }
    
    
    func showAlertAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension CenterViewController:TypesDelegate{
    func addType(id: Int) {
        presnter.addToSelectedTypes(id: id)
    }
    
    func deleteType(id: Int) {
        presnter.deleteFromSelectedType(id: id)
    }
    

    
    
}

