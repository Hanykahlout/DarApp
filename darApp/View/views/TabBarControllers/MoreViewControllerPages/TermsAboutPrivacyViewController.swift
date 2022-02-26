//
//  TermsAboutPrivacyViewController.swift
//  darApp
//
//  Created by Hani Mac on 03/08/2021.
//

import UIKit

class TermsAboutPrivacyViewController: UIViewController {

    @IBOutlet weak var textContentTextView: UITextView!
    @IBOutlet weak var headerNameLabel: UILabel!
    private let presnter = TeamsAboutPrivacyPresnter()
    var screenType:ScreenType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        presnter.delegate = self
        presnter.getContent()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension TermsAboutPrivacyViewController:TeamsAboutPrivacyPresnterDelegate{
    func setHeaderWithContent(content: String) {
        headerNameLabel.text = screenType.rawValue
        textContentTextView.text = content
    }
}
