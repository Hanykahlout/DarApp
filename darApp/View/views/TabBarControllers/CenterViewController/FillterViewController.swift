//
//  FillterViewController.swift
//  darApp
//
//  Created by Hani Mac on 04/08/2021.
//

import UIKit
import RangeSeekSlider

class FillterViewController: UIViewController {
    
    @IBOutlet weak var homeTypeTableView: UITableView!
    @IBOutlet weak var homeTypeHeightConstrant: NSLayoutConstraint!
    
    @IBOutlet weak var otherFeatureTableView: UITableView!
    @IBOutlet weak var otherFeatureHeightConstrant: NSLayoutConstraint!
    
    @IBOutlet var forWhatButtons: [UIButton]!
    
    @IBOutlet var specializationButtons: [UIButton]!
    
    @IBOutlet var bedroomsButtons: [UIButton]!
    private var selectedBedroomsButton:String = "1"
    
    @IBOutlet var bathroomsButtons: [UIButton]!
    private var selectedBathroomsButton:String = "1"
    
    
    @IBOutlet var livingRoomButtons: [UIButton]!
    private var selectedLivingRoomButton:String = "1"
    
    @IBOutlet var stateAge: [UIButton]!
    private var selectedStateAge:String = "5+"
    
    @IBOutlet var floorNumberButtons: [UIButton]!
    private var selectedFloorNumberButton:String = "1"
    
    @IBOutlet weak var comingSoonSwitch: UISwitch!
    
    @IBOutlet weak var priceRangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var spaceRangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var bedroomsView: UIView!
    
    @IBOutlet weak var bathroomView: UIView!
    
    @IBOutlet weak var livingRoomView: UIView!
    
    @IBOutlet weak var stateAgeView: UIView!
    
    @IBOutlet weak var floorNumber: UIView!
    
    private let presnter = FillterPresnter()
    
    private var currentHomeTypes = [TypeModel]()
    private var currentOtherFeature = [TypeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func initlization(){
        setUpTableView()
        presnter.delegate = self
        currentHomeTypes = presnter.getHomeTypes()
        currentOtherFeature = presnter.getOtherFeatures()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func xAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyAction(_ sender: Any) {
        presnter.applyAction()
    }
    
    @IBAction func forWhatAction(_ sender: UIButton) {
        presnter.setSelectedForWhatButton(forWhat: sender.titleLabel!.text!)
        presnter.switchSelectedButton(clickedButton: sender, buttons: forWhatButtons)
    }
    
    
    @IBAction func specializationAction(_ sender: UIButton) {
        presnter.setSelectedSpecializationButton(specialization: sender.titleLabel!.text!)
        presnter.switchSelectedButton(clickedButton: sender, buttons: specializationButtons)
    }
    
    
    @IBAction func bedroomsAction(_ sender: UIButton) {
        selectedBedroomsButton = sender.titleLabel!.text!
        presnter.switchSelectedButton(clickedButton: sender, buttons: bedroomsButtons)
    }
    
    @IBAction func bathroomsAction(_ sender: UIButton) {
        selectedBathroomsButton = sender.titleLabel!.text!
        presnter.switchSelectedButton(clickedButton: sender, buttons: bathroomsButtons)
    }
    
    @IBAction func livingRoomAction(_ sender: UIButton) {
        selectedLivingRoomButton = sender.titleLabel!.text!
        presnter.switchSelectedButton(clickedButton: sender, buttons: livingRoomButtons)
    }
    
    @IBAction func stateAgeAction(_ sender: UIButton) {
        selectedStateAge = sender.titleLabel!.text!
        presnter.switchSelectedButton(clickedButton: sender, buttons: stateAge)
    }
    
    @IBAction func floorNumberAction(_ sender: UIButton) {
        selectedFloorNumberButton = sender.titleLabel!.text!
        presnter.switchSelectedButton(clickedButton: sender, buttons: floorNumberButtons)
    }
    
    
}

extension FillterViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        homeTypeTableView.delegate = self
        homeTypeTableView.dataSource = self
        
        otherFeatureTableView.delegate = self
        otherFeatureTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == homeTypeTableView {
            return currentHomeTypes.count
        }
        return currentOtherFeature.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == homeTypeTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FillterTypesTableViewCell", for: indexPath) as! FillterTypesTableViewCell
            cell.delegate = self
            cell.setData(data: currentHomeTypes[indexPath.row],indexPath:indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterFeatureTableViewCell", for: indexPath) as! FilterFeatureTableViewCell
        cell.delegate = self
        cell.setData(data: currentOtherFeature[indexPath.row])
        return cell
    }
    
}


extension FillterViewController:FillterCellDelegate{
    
    func appendButtonToAll(button: UIButton) {
        presnter.appendToTypesButtons(button: button)
    }
    
    func select(title:String,id:Int,button: UIButton) {
        presnter.selectType(title:title,id:id,button: button)
    }
    
}


extension FillterViewController:FillterPresnterDelegate{
    
    func chooseViewToShow(selectedTypeTitle:String){
        switch selectedTypeTitle {
        case "floor" , "apartment":
            bedroomsView.isHidden = false
            bathroomView.isHidden = false
            livingRoomView.isHidden = false
            stateAgeView.isHidden = false
            floorNumber.isHidden = false
        case "villa":
            bedroomsView.isHidden = false
            bathroomView.isHidden = false
            livingRoomView.isHidden = false
            stateAgeView.isHidden = false
            floorNumber.isHidden = true
        case "office":
            bedroomsView.isHidden = true
            bathroomView.isHidden = true
            livingRoomView.isHidden = true
            stateAgeView.isHidden = false
            floorNumber.isHidden = false
        case "retail":
            bedroomsView.isHidden = true
            bathroomView.isHidden = true
            livingRoomView.isHidden = true
            stateAgeView.isHidden = false
            floorNumber.isHidden = false
        case "building":
            bedroomsView.isHidden = true
            bathroomView.isHidden = true
            livingRoomView.isHidden = true
            stateAgeView.isHidden = false
            floorNumber.isHidden = true
        case "resort":
            if presnter.getSelectedForWhatButton() == "For Sale"{
                bedroomsView.isHidden = true
                bathroomView.isHidden = true
                livingRoomView.isHidden = true
                stateAgeView.isHidden = true
                floorNumber.isHidden = false
            }else{
                bedroomsView.isHidden = true
                bathroomView.isHidden = true
                livingRoomView.isHidden = true
                stateAgeView.isHidden = true
                floorNumber.isHidden = true
            }
        case "land" , "warehouse" , "farm":
            bedroomsView.isHidden = true
            bathroomView.isHidden = true
            livingRoomView.isHidden = true
            stateAgeView.isHidden = true
            floorNumber.isHidden = true
        default:
            return
        }
    }
    
    func reloadHomeTypesTableView() {
        currentHomeTypes = presnter.getHomeTypes()
        homeTypeTableView.reloadData()
    }
    
    
    func changeOtherFeatureTableViewHeight(height: CGFloat) {
        otherFeatureHeightConstrant.constant = height
    }
    
    func reloadOtherFeaturesTableView() {
        currentOtherFeature = presnter.getOtherFeatures()
        otherFeatureTableView.reloadData()
    }
    
    func changeHomeTypeTableViewHeight(height: CGFloat) {
        homeTypeHeightConstrant.constant = height
    }
    
}


extension FillterViewController:FilterFeaturesCellDelegate{
    func appendToAll(button: UIButton) {
        presnter.appendToFeaturesButtons(button: button)
    }
    
    func select(title:String,button: UIButton) {
        presnter.selectFeature(title:title,button: button)
    }
}
