//
//  SearchVC.swift
//  Challenge-Eliq
//
//  Created by parto on 3/10/20.
//  Copyright © 2020 parto. All rights reserved.
//

import UIKit
import CoreData

class SearchVC: UIViewController{
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    // MARK: - Variables
    private var searchTimer : Timer?
    private var companyList : CompanyList = []
    private var selectedCompany: Company?
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    @IBAction func editingChanged(_ sender: Any) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false )
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        search()
    }
    
    @objc func search() {
        
        //Check if searchField isEmpty
        guard let keyWord = searchField.text, keyWord.isNotEmpty else {
            companyList = []
            tableView.reloadData()
            return
        }
        
        
        //Fetch Result
        loading.startAnimating()
        Company.fetchList(keyWord){ (companyList) in
            
            self.companyList = companyList!
            self.tableView.reloadData()
            self.loading.stopAnimating()
        }
        
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        searchField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailVC else {
            return
        }
        destinationVC.company = selectedCompany
    }
    
}
// MARK: - UITableViewDataSource
extension SearchVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        let name = companyList[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedCompany = companyList[indexPath.row]
        return indexPath
    }
    
}
