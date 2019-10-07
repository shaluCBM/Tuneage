//
//  Error.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-21.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation

struct ErrorWrapper : Codable {
    let error : ErrorDetails
}

struct ErrorDetails : Codable {
    let code : Int
    let errors : [ErrorProperties]
    let message : String
}

struct ErrorProperties : Codable {
    let domain : String
    let extendedHelp : String?
    let location : String?
    let locationType :String?
    let message : String
    let reason : String
}

