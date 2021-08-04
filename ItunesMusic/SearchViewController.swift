//
//  SearchViewController.swift
//  ItunesMusic
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 04.08.2021.
//

import UIKit
import Alamofire

struct Track {
    let trackName: String
    let artist: String
}

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let tracks = [
        Track(trackName: "Multibrendoviy", artist: "Scriptonit"),
        Track(trackName: "BOOM", artist: "Kangi")
    ]
    
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
        
        cell.textLabel?.text = "\(track.trackName)\n\(track.artist)"
        cell.detailTextLabel?.text = track.artist
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

        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(url).responseData { responseData in
            if responseData.error != nil {
                return
            }
            
            guard let data = responseData.data else { return }
            
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }
    }
}
