//
//  MainTabBarViewController.swift
//  darApp
//
//  Created by Hani Mac on 25/07/2021.
//

import UIKit

class MainTabBarViewController: UITabBarController , UITabBarControllerDelegate{
    private var middleBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.85)
        tabBar.tintColor = #colorLiteral(red: 0.8196078431, green: 0.1058823529, blue: 0.1058823529, alpha: 1)
        self.delegate = self
        setupMiddleButton()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 100, height: 100))
        
        //STYLE THE BUTTON YOUR OWN WAY
        middleBtn.setImage(#imageLiteral(resourceName: "sas"), for: .normal)
        middleBtn.imageEdgeInsets = UIEdgeInsets.init(top: -74, left: -50, bottom: 0, right: 0)
        //add to the tabbar and add click event
        tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        if selectedViewController is CenterViewController{
            let home = selectedViewController as! CenterViewController
            if home.isMap {
                middleBtn.setImage(#imageLiteral(resourceName: "5443"), for: .normal)
                home.fillterOptionsView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                home.mapView.isHidden = true
                home.cardView.isHidden = true
                home.handButton.isHidden = true
                home.darsTableView.isHidden = false
                home.isMap = false
            }else{
                middleBtn.setImage(#imageLiteral(resourceName: "sas"), for: .normal)
                home.fillterOptionsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)
                home.mapView.isHidden = false
                home.cardView.isHidden = true
                home.handButton.isHidden = false
                home.darsTableView.isHidden = true
                home.isMap = true
            }
        }
        self.selectedIndex = 2
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if !(viewController is CenterViewController) {
            middleBtn.setImage(#imageLiteral(resourceName: "23423243"), for: .normal)
        }
    }
    
}


