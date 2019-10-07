//
//  Services.swift
//  POCHistory
//
//  Created by Shalu Scaria on 2018-12-20.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation

class Services {
    static let shared = Services()
    
    
    lazy var connectionManager = ConnectionManager()
}
