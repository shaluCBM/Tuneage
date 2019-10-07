//
//  HistoryViewController.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-17.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.tableFooterView = UIView()
    }
    

    
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableCell", for: indexPath) as? HistoryTableCell {
            cell.update(
                title: " Theri Songs | En Jeevan Official Video Song | Vijay, Samantha | Atlee | G.V.Prakash Kumar Think Music India",
                videoUrl:URL(string: "https://www.youtube.com/embed/LoPf32nKYb8?autoplay=1")!,
                videoId: "LoPf32nKYb8")
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
    
}
