//
//  SearchResult.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-20.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation

struct Search : Codable {
    let kind : String
    let etag : String
    let nextPageToken : String
    let prevPageToken : String?
    let regionCode : String
    let items : [Item]
    let pageInfo : PageInfo
}

struct PageInfo : Codable {
    let totalResults : Int
    let resultsPerPage : Int
}

