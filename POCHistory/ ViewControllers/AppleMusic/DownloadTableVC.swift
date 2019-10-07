//
//  DownloadTableVC.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2019-01-03.
//  Copyright © 2019 Shalu Scaria. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol DownloadTableViewCellDelegate: class {
    func downloadDidFinished()
}

class DownloadTableVC: UIViewController, DownloadTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var resources = [JSON]()
    weak var delegate: DownloadTableViewDelegate?
    @IBAction func closeButtonTapped(_  sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
    }
    
    func downloadDidFinished() {
        self.dismiss(animated: true)
        delegate?.downloadComplete()
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DownloadTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
        cell.delegate = self
        
        for categoryRequest in resources[indexPath.row]["categoryRequests"].arrayValue {
            cell.textLabel?.text = categoryRequest["name"].stringValue
            if categoryRequest["name"].stringValue == "Apple Media Services information" {
                let zonesName = categoryRequest["zones"].arrayValue[0]["name"].stringValue
                
                let escapedRequestName = categoryRequest["name"].stringValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
                let userRequestsId = resources[indexPath.row]["id"].stringValue
                
                let urlString = "https://privacy.apple.com/download/request/" + userRequestsId + "/zone/" + zonesName + "?f=" + escapedRequestName
                
                cell.url = urlString
            }
        }
        
        return cell
    }
    
    
}


