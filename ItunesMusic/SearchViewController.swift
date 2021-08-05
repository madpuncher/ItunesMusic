//
//  SearchViewController.swift
//  ItunesMusic
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 04.08.2021.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setupSearchController()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let track = tracks[indexPath.row]
        
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines =  2
        cell.imageView?.image = UIImage(systemName: "heart")
        return cell
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search"
            
            let parameters = ["term": "\(searchText)", "limit": "10"]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { responseData in
                if responseData.error != nil {
                    return
                }
                
                guard let data = responseData.data else { return }
                
                do {
                    let objects = try JSONDecoder().decode(SearchResponse.self, from: data)
                    self.tracks = objects.results
                    self.tableView.reloadData()
                    
                } catch let error {
                    print(error)
                }
            }
            
        })
        
    }
}
