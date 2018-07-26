//
//  ViewModel.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 25.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation
import CoreLocation

typealias Completion = (()->())

class ViewModel {
    
    private let apiService: APIService
    var issPosition: IssPosition?
    private var issCrew: [CrewMan] = []
    
    var timeText: String {
        guard let timeStamp = issPosition?.timestamp else { return "???" }
        return Helper.getDateFromTimestamp(timeStamp)
    }
    
    var positionText: String {
        guard let issPosition = issPosition else { return "???" }
        return String(format: "latitude: %@ / longitude: %@", issPosition.position.latitude, issPosition.position.longitude)
    }
    
    var issPositionCoordinate: CLLocationCoordinate2D {
        guard
            let issPosition = issPosition,
            let latitude  = Double(issPosition.position.latitude),
            let longitude = Double(issPosition.position.longitude)
            else { return CLLocationCoordinate2DMake(0, 0) }

        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    lazy var issCrewString: String = {
        let array = issCrew.map { $0.name }
        let crew = array.joined(separator: ", ")
        return crew
    }()
    
    
    // MARK: - Init
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    
    // MARK: - Last session position
    
    func getLastSessionSavedPosition() {
        self.issPosition = UserDefaultsService.shared.issPosition
    }
    
    private func saveNewIssPosition(newIssPosition: IssPosition) {
        UserDefaultsService.shared.issPosition = newIssPosition
    }
    
    // MARK: - Networking
    
    func getCurrentIssPosition(completion: @escaping Completion) {
        apiService.getIssPositionData { (newPosition) in
            self.issPosition = newPosition
            self.saveNewIssPosition(newIssPosition: newPosition)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getIssCrew(completion: @escaping Completion) {
        apiService.getIssCrewData { (crew) in
            self.issCrew = crew
            completion()
        }
    }
}
