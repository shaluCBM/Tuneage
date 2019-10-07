//
//  Item.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-20.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation

class Item : Codable {
    let etag : String
    let id : VideoID
    let kind : String
    let snippet : Snippet
}


class VideoID : Codable {
    let kind : String
    let videoId : String
}

class Snippet : Codable {
    let channelId : String
    let channelTitle : String
    let description : String
    let liveBroadcastContent : String
    let publishedAt : String
    let thumbnails : Thumbnail
    let title : String
}

class Thumbnail : Codable {
    let `default` : ThumbnailProperties
    let high : ThumbnailProperties
    let medium : ThumbnailProperties
}

class ThumbnailProperties : Codable {
    let height : Int
    let url : String
    let width : Int
}


