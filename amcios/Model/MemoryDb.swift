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
    
    /// Contains the headers for the list view
    var headers: [String] {
        guard let data = data else { return [] }
        return data.conferences.reduce([]) { (curr, conf) -> [String] in
            var tmp = curr
            if(!curr.contains(conf.yearMonth)) {
                tmp.append(conf.yearMonth)
            }
            return tmp
        }
    }

    /// Contains last update date
    var lastUpdate = Date()
}
