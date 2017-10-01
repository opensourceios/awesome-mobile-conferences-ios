//
//  Conference.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import Foundation

struct Conference: Codable {
    let title: String
    let year: Int
    let startdate: String
    let enddate: String
    let location: String
    let homepage: String
    let country: String
    let callforpaper: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case year
        case startdate
        case enddate
        case homepage
        case country
        case callforpaper
        
        case location = "where"
    }
}
