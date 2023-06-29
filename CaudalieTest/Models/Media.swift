//
//  Media.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import Foundation

final class Media: Decodable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let trackViewUrl: String?
    let artworkUrl100: String?
    let longDescription: String?
    
    init(artistName: String?, collectionName: String?, trackName: String?, trackViewUrl: String?, artworkUrl100: String?, longDescription: String?) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.trackViewUrl = trackViewUrl
        self.artworkUrl100 = artworkUrl100
        self.longDescription = longDescription
    }
}

struct GetMediaListResponse: Decodable {
    let results: [Media]
}
