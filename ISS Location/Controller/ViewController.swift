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
        
        RequestManager.getIssPositionData { (position) in
            self.issPosition = position
        }
        
        RequestManager.getIssCrewData { (crew) in
            self.issCrew = crew
        }
    }
}

