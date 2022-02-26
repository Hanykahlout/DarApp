//
//  HomeViewController.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit
import Cosmos
import FSCalendar
class HomeViewController: UIViewController {
    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var owner_bioLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var type_EstateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var topImagesCollectionView: UICollectionView!
    @IBOutlet weak var factsFeaturesCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var factCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var calndarView: FSCalendar!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var RequestVistAlertView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var favorateButton: UIButton!
    
    
    
    public var id:Int!
    private let presnter = HomePresnter()
    private var selectedTime:String = "11:00"
    private var selectedDate:Date?
    private var allImages = [String]()
    private var factsFeaturesData = [FactData]()
    private var timesData = [String]()
    private var similarData = [SimilarData]()
    private var personalImageURL:String = ""
    private var ownerName:String = ""
    private var ownerBio:String = ""
    private var ownerAddress:String = ""
    private var ownerRate:Double = 0.0
    private var ownerPhone = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presnter.getEstateData(by: String(id))
        timesData = presnter.getTimeData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        presnter.delegate = self
        setUpTextView()
        setUpViews()
        setUpTopImagesCollectionView()
        setUpTimeCollectionView()
        setUpSimilarCollectionView()
        setUpFactsFeaturesCollectionView()
        
    }
    
    
    private func setUpViews(){
        profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfileVC)))
        shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didShadowClicked)))
    }
    
    
    private func setUpTextView(){
        messageTextView.delegate = self
        messageTextView.text = "Message"
        messageTextView.textColor = #colorLiteral(red: 0.7137254902, green: 0.7490196078, blue: 0.7411764706, alpha: 1)
    }
    
    private func showVisitAlert(){
        if let _ = selectedDate{
            RequestVistAlertView.isHidden = false
            shadowView.isHidden = false
        }else{
            let alert = UIAlertController(title: "Error", message: "You must make an appointment to visit", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func updatePageControlNumber(imagesCount: Int) {
        pageControl.numberOfPages = imagesCount
    }
    
    
    @objc func goToProfileVC(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.ownerId = id
        vc.ownerPhone = ownerPhone
        vc.imageURL = personalImageURL
        vc.name = ownerName
        vc.bio = ownerBio
        vc.address = ownerAddress
        vc.rate = ownerRate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func didShadowClicked(){
        hideVisitRequestView()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func favorateAction(_ sender: Any) {
        if favorateButton.isSelected{
            presnter.deleteFromFavorit(by: id)
        }else{
            presnter.addToFavorit(by: id)
        }
        favorateButton.isSelected = !favorateButton.isSelected
    }
    
    
    @IBAction func requestVisiAction(_ sender: Any) {
        showVisitAlert()
    }
    
    
    @IBAction func chatAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func phoneAction(_ sender: Any) {
        if let url = URL(string: "tel://"+ownerPhone), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func viewInCalendarAction(_ sender: Any) {
        centerView.isHidden = false
        shadowView.isHidden = false
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        didShadowClicked()
    }
    
    
    @IBAction func okAction(_ sender: Any) {
        if let date = calndarView.selectedDate{
            selectedDate = date
            presnter.getDateString(date: date)
        }
        didShadowClicked()
    }
    
    
    @IBAction func requestVistInAlertAction(_ sender: Any) {
        presnter.makeVisitRequest(id: id, date: selectedDate!, time: selectedTime, phone: phoneNumberTextField.text!, message: messageTextView.text)
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    private func setUpTopImagesCollectionView(){
        topImagesCollectionView.delegate = self
        topImagesCollectionView.dataSource = self
    }
    
    private func setUpFactsFeaturesCollectionView(){
        factsFeaturesCollectionView.delegate = self
        factsFeaturesCollectionView.dataSource = self
    }
    
    private func setUpTimeCollectionView(){
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
    }
    
    private func setUpSimilarCollectionView(){
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case factsFeaturesCollectionView :
            return factsFeaturesData.count
        case topImagesCollectionView:
            return allImages.count
        case timeCollectionView:
            return timesData.count
        case similarCollectionView:
            return similarData.count
        default:
            return 10
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case factsFeaturesCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactFeaturesCollecationViewCell", for: indexPath) as! FactFeaturesCollecationViewCell
            cell.setData(data:factsFeaturesData[indexPath.row])
            return cell
        case topImagesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImageCollectionViewCell", for: indexPath) as! TopImageCollectionViewCell
            cell.setEstateImage(imageUrl: allImages[indexPath.row])
            return cell
        case timeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
            cell.timeLabel.text = timesData[indexPath.row]
            return  cell
        case similarCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCell", for: indexPath) as! SimilarCollectionViewCell
            cell.setData(data: similarData[indexPath.row])
            return cell
        default:
            return .init()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case factsFeaturesCollectionView :
            return CGSize(width: topImagesCollectionView.frame.width / 3, height: 30)
        case topImagesCollectionView:
            return CGSize(width: topImagesCollectionView.frame.width, height: topImagesCollectionView.frame.height)
        case timeCollectionView:
            return CGSize(width: 110, height: 46)
        case similarCollectionView:
            return CGSize(width: 160, height: 186)
        default:
            return .zero
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contains(topImagesCollectionView){
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == timeCollectionView{
            appointmentLabel.text = "Book an appointment for a visit is scheduled for \(timesData[indexPath.row])"
            selectedTime = timesData[indexPath.row]
        }else if collectionView == similarCollectionView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.id = similarData[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension HomeViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Message"
            &&  textView.textColor == #colorLiteral(red: 0.7137254902, green: 0.7490196078, blue: 0.7411764706, alpha: 1){
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Message"
            textView.textColor = #colorLiteral(red: 0.7137254902, green: 0.7490196078, blue: 0.7411764706, alpha: 1)
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
}


extension HomeViewController:HomePresenterDelegate{
    func hideVisitRequestView() {
        RequestVistAlertView.isHidden = true
        centerView.isHidden = true
        shadowView.isHidden = true
    }
    
    
    func changeSelectionFavoritButton(to: Bool) {
        favorateButton.isSelected = to
    }
    
    
    func setAllData(data: HomeInfoData) {
        if let ads = data.ads{
            
            allImages = presnter.getImages()
            updatePageControlNumber(imagesCount: allImages.count)
            topImagesCollectionView.reloadData()
            
            factsFeaturesData = presnter.getFactData()
            factsFeaturesCollectionView.reloadData()
            
            similarData = presnter.getSimilarData()
            similarCollectionView.reloadData()
            
            priceLabel.text = "\(String(ads.price ?? 0))SA"
            addressLabel.text = ads.address ?? ""
            ownerAddress = ads.address ?? ""
            typeLabel.text = ads.type ?? ""
            createdAtLabel.text = ads.creted_at ?? ""
            type_EstateLabel.text = ads.type_Estate_text ?? ""
            descriptionLabel.text = ads.description ?? ""
            ownerImageView.sd_setImage(with: URL(string: ads.owner_img ?? ""), placeholderImage: #imageLiteral(resourceName: "person-icon-8"))
            personalImageURL = ads.owner_img ?? ""
            ownerNameLabel.text = ads.owner_name ?? ""
            ownerName = ads.owner_name ?? ""
            owner_bioLabel.text = ads.owner_bio ?? ""
            ownerBio = ads.owner_bio ?? ""
            let rate = Double(ads.owner_rate ?? 1)
            ratingView.rating = rate
            ownerRate = rate
            favorateButton.isSelected = ads.is_favourite ?? false
            ownerPhone = ads.owner_phone ?? ""
        }
    }
    
    
    func updateFactCollectionViewHeight(factCount: Int) {
        factCollectionViewHeight.constant = CGFloat((factCount / 2) * 30)
    }
    
    
    func setDateInDateLabel(date: String) {
        dateLabel.text = date
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
