//
//  SearchViewController.swift
//  darApp
//
//  Created by Hani Mac on 05/08/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var noResultImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    public var searchText:String!
    private var results = [SearchResultInfo]()
    private let presnter = SearchPresnter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = searchText
        getResultData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()

    }
    
    private func initialization() {
        presnter.delegage = self
        setUpTableView()
    }
    
    private func getResultData(){
        results = presnter.getSearchResult(text: searchText)
        if !results.isEmpty{
            noResultImageView.isHidden = true
            searchResultsTableView.isHidden = false
        }else{
            noResultImageView.isHidden = false
            searchResultsTableView.isHidden = true
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    @IBAction func xAction(_ sender: Any) {
    }
    
    @IBAction func filterAction(_ sender: Any) {
    }
    
    
}


extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func setUpTableView(){
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        cell.setData(result: results[indexPath.row])
        return cell
    }
    
}

extension SearchViewController:SearchPresnterDelegate{
    
}
