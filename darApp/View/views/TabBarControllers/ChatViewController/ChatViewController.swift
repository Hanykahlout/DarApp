//
//  ChatViewController.swift
//  darApp
//
//  Created by Hani Mac on 27/07/2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatsTableView: UITableView!
    @IBOutlet weak var noChatsImageView: UIImageView!
    @IBOutlet weak var noChatLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    private var chatsInfo = [ChatInfo]()
    private let presnter = ChatPresnter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if UserDefaultsData.shard.isLoggedIn() {
            createAccountButton.isHidden = true
            chatsInfo = presnter.getChatsData()
        }else{
            createAccountButton.isHidden = false
            noChatsImageView.isHidden = false
            noChatLabel.isHidden = false
            chatsTableView.isHidden = true
        }
    }
    
    
    private func initlization(){
        presnter.delegate = self
        setUpTableView()
    }
    

    private func getChatsData(){
        if chatsInfo.isEmpty {
            chatsTableView.isHidden = true
            noChatsImageView.isHidden = false
            noChatLabel.isHidden = false
        }else{
            chatsTableView.isHidden = false
            noChatsImageView.isHidden = true
            noChatLabel.isHidden = true
        }
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}


extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.setData(chatInfo: chatsInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension ChatViewController:ChatPresnterDelegate{
    
}
