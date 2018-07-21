//
//  IssPosition.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct IssPosition: Decodable {
    let position:  Position
    let timestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case position = "iss_position"
        case timestamp
    }
}

struct Position: Decodable {
    let latitude:  String
    let longitude: String
}
