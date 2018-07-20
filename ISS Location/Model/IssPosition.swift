//
//  IssPosition.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation

struct IssPosition: Decodable {
    var position: Position
    var timestamp:   Int
    
    enum CodingKeys: String, CodingKey {
        case position = "iss_position"
        case timestamp
    }
}

struct Position: Decodable {
    var latitude:  String
    var longitude: String
}
