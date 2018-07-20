//
//  ViewController.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {
    
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var lastPositionLabel: UILabel!
    
    private var issPosition: IssPosition?
    private var issCrew: [CrewMan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentPosition()
        getCrewInfo()
    }
    
    private func getCurrentPosition() {
        RequestManager.getIssPositionData { (position) in
            self.issPosition = position
            self.refreshView()
        }
    }
    
    private func getCrewInfo() {
        RequestManager.getIssCrewData { (crew) in
            self.issCrew = crew
        }
    }

    private func refreshView() {
        guard let issPosition = issPosition else { return }
        
        lastTimeLabel.text = Helper.getDateFromTimestamp(issPosition.timestamp)
        print(issPosition.position.latitude)
        print(issPosition.position.longitude)
        
        let position = String(format: "latitude: %@ / longitude: %@", issPosition.position.latitude, issPosition.position.longitude)
        lastPositionLabel.text = position
    }
}

