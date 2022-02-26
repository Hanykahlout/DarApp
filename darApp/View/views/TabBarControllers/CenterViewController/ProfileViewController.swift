//
//  ProfileViewController.swift
//  darApp
//
//  Created by Hani Mac on 09/08/2021.
//

import UIKit
import Cosmos
class ProfileViewController: UIViewController {

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var activitesCollectionView: UICollectionView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var editableRatingView: CosmosView!
    @IBOutlet weak var ownerAddressLabel: UILabel!
    private var activitiesData = [ActiviteInfo]()
    private let presnter = ProfilePresnter()
    
    public var ownerId:Int!
    public var ownerPhone:String!
    public var imageURL:String!
    public var name:String!
    public var address:String!
    public var bio:String!
    public var rate:Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setOwnerData()
        activitiesData = presnter.getActivitesData()
    }
    
    private func initlization(){
        presnter.delegate = self
        setUpCollectionView()
        setLayers()
        editableRatingView.didTouchCosmos = { rating in
            self.presnter.updateRating(id: self.ownerId, rate: rating)
        }
    }
    

    
    private func setLayers(){
        let layer = UICollectionViewFlowLayout()
        layer.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 0)
        layer.scrollDirection = .horizontal
        layer.minimumInteritemSpacing = 0
        layer.minimumLineSpacing = 20
        layer.invalidateLayout()
        
        let size = ((activitesCollectionView.frame.height / 2) - 16)
        layer.itemSize = CGSize(width: 110, height: size)
        activitesCollectionView.setCollectionViewLayout(layer, animated: false)
    }
    
    private func setOwnerData(){
        ownerImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "person-icon-8"))
        ownerNameLabel.text = name
        bioLabel.text = bio
        ownerAddressLabel.text = address
        rateView.rating = rate
        editableRatingView.rating = rate
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func chatAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func phoneAction(_ sender: Any) {
        if let url = URL(string: "tel://"+ownerPhone), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func emailAction(_ sender: Any) {
        if let url = URL(string: "mailto:"+"hanykahlout@gmail.com"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func setUpCollectionView(){
        activitesCollectionView.delegate = self
        activitesCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitesCollectionViewCell", for: indexPath) as! ActivitesCollectionViewCell
        cell.setData(data: activitiesData[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController:ProfilePresnterDelegate{
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
