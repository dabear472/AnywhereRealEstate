//
//  MasterViewController.swift
//  GlobalAnywhere
//
//  Created by Jonathan Buford on 4/27/23.
//

import UIKit

class MasterViewController: UIViewController,
                                UINavigationControllerDelegate,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                UISearchBarDelegate,
                                UISearchResultsUpdating,
                                UISearchControllerDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    let searchController = UISearchController()
    var dataModel: [FirstCallDataModel]?
    var filteredDataModel: [FirstCallDataModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self
        
        self.navigationController?.delegate = self

        NotificationCenter.default.addObserver(self,
                                              selector: #selector(self.configureData(_:)),
                                              name: NSNotification.Name(rawValue: "decodedDataReceived"),
                                              object: nil)
        
        NetworkTraffic.shared.gatherData(withSimpsons: true)
        
        initSearchController()
    }
    
    func initSearchController() {
        self.searchController.loadViewIfNeeded()
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.enablesReturnKeyAutomatically = false
        self.searchController.searchBar.returnKeyType = UIReturnKeyType.go
        definesPresentationContext = true
        
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataHold = self.dataModel {
            if searchController.isActive {
                if let filteredData = filteredDataModel {
                    return filteredData.count
                } else {
                    return 1
                }
            }
            return dataHold.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterViewCell") as! MasterViewCell
        if searchController.isActive {
            if let filteredData = self.filteredDataModel {
                cell.dataModel = filteredData[indexPath.row]
            } else {
                cell.setupErrorCell()
            }
        } else {
            if let modelData = self.dataModel {
                cell.dataModel = modelData[indexPath.row]
            } else {
                cell.setupErrorCell()
            }
        }
        cell.setupView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            if let filteredData = self.filteredDataModel {
                GlobalVariables.shared.dataModel = filteredData[indexPath.row]
            }
        } else {
            if let modelData = self.dataModel {
                GlobalVariables.shared.dataModel = modelData[indexPath.row]
            }
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "GlobalMainStoryboard", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterForSearchText(withSearchText: searchText)
    }
    
    func filterForSearchText(withSearchText: String) {
        filteredDataModel = dataModel?.filter() {
            filteredData in
            if searchController.searchBar.text != "" {
                let searchTextMatch = filteredData.Text.lowercased().contains(withSearchText.lowercased())
                
                return searchTextMatch
            } else {
                return false
            }
        }
        tableViewOutlet.reloadData()
    }

    
    @objc private func configureData(_ notification: NSNotification) {
        if let passData = notification.userInfo?["decodedData"] as? [FirstCallDataModel] {
            self.title = "Character Names"
            self.dataModel = passData
            self.tableViewOutlet.reloadData()
        }
    }
}

