//
//  MasterViewController.swift
//  GlobalAnywhere
//
//  Created by Jonathan Buford on 4/27/23.
//

import UIKit

class MasterViewController: UITableViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var dataModel: [FirstCallDataModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewOutlet.delegate = self
        self.tableViewOutlet.dataSource = self

        NotificationCenter.default.addObserver(self,
                                              selector: #selector(self.configureData(_:)),
                                              name: NSNotification.Name(rawValue: "decodedDataReceived"),
                                              object: nil)
        
        NetworkTraffic.shared.gatherData(withSimpsons: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataHold = self.dataModel {
            return dataHold.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterViewCell") as! MasterViewCell
        if let modelData = self.dataModel {
            cell.dataModel = modelData[indexPath.row]
            cell.setupView()
        } else {
            cell.setupErrorCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let modelData = self.dataModel {
            GlobalVariables.shared.dataModel = modelData[indexPath.row]
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "GlobalMainStoryboard", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @objc private func configureData(_ notification: NSNotification) {
        if let passData = notification.userInfo?["decodedData"] as? [FirstCallDataModel] {
            self.title = "Character Names"
            self.dataModel = passData
            self.tableViewOutlet.reloadData()
        }
    }
}

