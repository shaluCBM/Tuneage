//
//  SearchViewController.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-19.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive = false
    var searchComplete = false
    var searchResults : Search! = nil
    var searchText : String = ""
    var selectedIndex : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
        tableView.tableFooterView = UIView()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = true
        DispatchQueue.main.async {
            Services.shared.connectionManager.makeRequest(searchText: self.searchText, completion: {search, errorMsg in
                guard let search = search else {return}
                self.searchResults = search
                self.searchComplete = true
                self.tableView.reloadData()
            } )
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        self.tableView.reloadData()
    }
    
    //MARK: - table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchComplete {
            return searchResults.items.count
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchComplete {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as? SearchResultCell {
                let snippet = searchResults.items[indexPath.row].snippet
                if  let url = URL(string: snippet.thumbnails.default.url) {
                    //print("URL printed", url)
                    cell.update(title: snippet.title,
                               channelTitle: snippet.channelTitle,
                               url: url)
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "watchVideoVCSegue", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "watchVideoVCSegue" {
            let viewController = segue.destination as? WatchVideoVC
            viewController?.items = self.searchResults.items
            viewController?.itemIndex = selectedIndex
        }
    }
}
