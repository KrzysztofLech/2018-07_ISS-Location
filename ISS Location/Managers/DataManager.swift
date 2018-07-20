//
//  DataManager.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import CoreLocation

class DataManager {
    
    static let shared = DataManager()
    
    var issPosition: IssPosition?
    var issCrew: [CrewMan] = []
    
    private init() { }
    
    
    // MARK: - Position methods
    
    func getCurrentIssPosition(completion: @escaping (()->())) {
        RequestManager.getIssPositionData { (newIssPosition) in
            self.saveNewIssPosition(newIssPosition: newIssPosition)
            self.issPosition = newIssPosition
            completion()
        }
    }

    private func saveNewIssPosition(newIssPosition: IssPosition) {
        UserDefaultsManager.shared.issPosition = newIssPosition
    }
    
    func loadSavedIssPosition(completion: (()->())) {
        if let loadedPosition = UserDefaultsManager.shared.issPosition {
            self.issPosition = loadedPosition
            completion()
        }
    }
    
    func getLastISSPositionCoordinate() -> CLLocationCoordinate2D? {
        guard
            let issPosition = issPosition,
            let latitude  = Double(issPosition.position.latitude),
            let longitude = Double(issPosition.position.longitude)
        else { return nil }
        
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    func getLastISSPositionCoordinateString() -> String {
        guard let issPosition = issPosition else { return "???" }
        return String(format: "latitude: %@ / longitude: %@", issPosition.position.latitude, issPosition.position.longitude)
    }
    
    func getLastISSPositionTime() -> String? {
        guard let timeStamp = issPosition?.timestamp else { return nil }
        return Helper.getDateFromTimestamp(timeStamp)
    }
    
    
    // MARK: - Crew methods
    
    func getIssCrew() {
        RequestManager.getIssCrewData { (crewArray) in
            self.issCrew = crewArray
        }
    }
}
