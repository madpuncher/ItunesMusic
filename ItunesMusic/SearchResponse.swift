//
//  SearchResponse.swift
//  ItunesMusic
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.08.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var artistName: String
    var trackName: String
    var artworkUrl100: String?
}
