//
//  UserDefaultsManager.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import CoreLocation

struct UserDefaultsKey {
    static let issPosition = "ISS position"
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    // MARK: - Private methods
    
    private init() {}
    
    private func write(object: Any, forKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
    }
    
    private func getObject(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    private func removeObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    // MARK: - Public properties and methods
    
    var issPosition: IssPosition? {
        get {
            if
                let dictionary = getObject(forKey: UserDefaultsKey.issPosition) as? [String : Any],
                let latitudeStr  = dictionary["latitude"] as? String,
                let longitudeStr = dictionary["longitude"] as? String,
                let timestamp = dictionary["timestamp"] as? Int {
                
                let position = Position(latitude: latitudeStr, longitude: longitudeStr)
                return IssPosition(position: position, timestamp: timestamp)
            }
            return nil
        }
        set {
            if let value = newValue {
                let dictionary: [String : Any] = [
                    "latitude"  : value.position.latitude,
                    "longitude" : value.position.longitude,
                    "timestamp" : value.timestamp
                ]
                write(object: dictionary, forKey: UserDefaultsKey.issPosition)
            }
        }
    }
}
