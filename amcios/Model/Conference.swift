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
    let emojiflag: String
    let callforpaper: Bool
    let isNew: Bool

    /// runtime value useful for sorting
    var start: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: startdate)
    }
    
    /// return current year/month
    var yearMonth: String {
        guard let start = start else { return "" }
        return start.toString(dateFormat: "yyyy / MMMM").capitalized
    }

    /// Check if project is favorite locally (sync via iCloud)
    var isFavorite: Bool {
        get {
            return UserDefaults.standard.bool(forKey: homepage)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: homepage)
            UserDefaults.standard.synchronize()
        }
    }

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case startdate
        case enddate
        case homepage
        case country
        case callforpaper
        case emojiflag

        case location = "where"
        case isNew = "isnew"
    }
}
