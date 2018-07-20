//
//  Helper.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct Helper {
    
    static func getDateFromTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        let formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
}
