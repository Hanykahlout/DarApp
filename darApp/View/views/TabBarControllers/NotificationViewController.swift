//
//  NotificationViewController.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var noNotificationImageView: UIImageView!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private var notification = [NotificationData]()
    private let presnter = NotificationPresnter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        if UserDefaultsData.shard.isLoggedIn(){
            createAccountButton.isHidden = true
            getNotifications()
        }else{
            createAccountButton.isHidden = false
            noNotificationImageView.isHidden = false
            notificationTableView.isHidden = true
        }
    }
    
    private func initlization(){
        presnter.delegate = self
        setupTableView()
    }
    
    
    private func getNotifications(){
        notification = presnter.getNotificationData()
        if notification.isEmpty{
            notificationTableView.isHidden = true
            noNotificationImageView.isHidden = false
        }else{
            notificationTableView.isHidden = false
            noNotificationImageView.isHidden = true
        }
    }
    
    
    @IBAction func createAccountAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    
}

extension NotificationViewController:UITableViewDelegate,UITableViewDataSource{
    private func setupTableView(){
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vw = UIView( frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        vw.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let label = UILabel(frame: .init(x: 10, y: (vw.frame.size.height/2) - 8, width: 150, height: 16))
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        label.textColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.2549019608, alpha: 1)
        if section == 0 {
            label.text = "NEW"
        }
        vw.addSubview(label)
        return vw
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfNewNotification = 0
        for item in notification{
            if item.isNew{
                numberOfNewNotification += 1
            }
        }
        if section == 0 {
            return numberOfNewNotification
        }
        return notification.count - numberOfNewNotification
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.setData(notification: notification[indexPath.row])
        return cell
     }
    
}

extension NotificationViewController:NotificationPresnterDelegate{
    
}
