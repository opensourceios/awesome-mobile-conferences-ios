//
//  MemoryDb.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import Foundation

class MemoryDb {
    /// Shared instance
    open static var shared = MemoryDb()
    private init() {}
    
    /// Contains data
    var data: Awesome? {
        didSet {
            lastUpdate = Date()
        }
    }
    
    /// Contains last update date
    var lastUpdate = Date()
}
