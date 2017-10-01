//
//  AMCApi.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import Foundation

class AMCApi {
    class func getData() -> Data? {
        do {
            let data = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/AwesomeMobileConferences/awesome-mobile-conferences/master/contents.json")!)
            return data
        } catch (let error) {
            print("🙅 \(error)")
            return nil
        }
    }
    
}
