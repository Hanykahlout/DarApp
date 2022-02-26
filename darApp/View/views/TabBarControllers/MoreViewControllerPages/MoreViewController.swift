//
//  MoreViewController.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var SingleNearMeView: UIView!
    @IBOutlet weak var infoNearMeView: UIView!
    @IBOutlet weak var myInfoView: UIView!
    @IBOutlet weak var nearMeView: UIView!
    @IBOutlet weak var aboutDarView: UIView!
    @IBOutlet weak var termsOfUseView: UIView!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var contactUsView: UIView!
    @IBOutlet weak var spacingBetweenViewsContrant: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contactUsAlertView: UIView!
    @IBOutlet weak var languageAlertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpIsLoggedInAction()
    }
    
    
    private func initlization(){
        setUpViews()
        shadowView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideShadowAlertView)))
    }
    
    
    @objc private func hideShadowAlertView(){
        shadowView.isHidden = true
        languageAlertView.isHidden = true
        contactUsAlertView.isHidden = true
    }
    
    
    private func setUpIsLoggedInAction(){
        if UserDefaultsData.shard.isLoggedIn() {
            SingleNearMeView.isHidden = true
            loginButton.isHidden = true
            infoNearMeView.isHidden = false
            spacingBetweenViewsContrant.constant = 99
        }else{
            SingleNearMeView.isHidden = false
            loginButton.isHidden = false
            infoNearMeView.isHidden = true
            spacingBetweenViewsContrant.constant = 36
        }
    }
    
    private func setUpViews(){
        SingleNearMeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nearMeAction)))
        nearMeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nearMeAction)))
        myInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myInfoAction)))
        aboutDarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aboutDarAction)))
        termsOfUseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsOfUseAction)))
        privacyPolicyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyPolicyAction)))
        languageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(languageAction)))
        contactUsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contactUsAction)))
    }
    
    
    @objc private func nearMeAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "NearMeViewController") as! NearMeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func myInfoAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func aboutDarAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsAboutPrivacyViewController") as! TermsAboutPrivacyViewController
        vc.screenType = .AboutDar
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func termsOfUseAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsAboutPrivacyViewController") as! TermsAboutPrivacyViewController
        vc.screenType = .TermsOfUser
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func privacyPolicyAction(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsAboutPrivacyViewController") as! TermsAboutPrivacyViewController
        vc.screenType = .PrivacyPolicy
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func languageAction(){
        shadowView.isHidden = false
        languageAlertView.isHidden = false
    }
    
    @objc private func contactUsAction(){
        shadowView.isHidden = false
        contactUsAlertView.isHidden = false
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func englishAction(_ sender: Any) {
        hideShadowAlertView()
    }
    
    @IBAction func arbicAction(_ sender: Any) {
        hideShadowAlertView()
    }
    
    @IBAction func whatsappAction(_ sender: Any) {
        hideShadowAlertView()
    }
    
    @IBAction func gmailAction(_ sender: Any) {
        hideShadowAlertView()
    }
    
    
}
