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
    
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var lastPositionLabel: UILabel!
    
    private var issPosition: IssPosition?
    private var issCrew: [CrewMan] = []
    
    private let timeInterval: Double = 5.0
    private var mapPointAnnotation: MGLPointAnnotation!
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentPosition()
        getCrewInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addPointAnnotationToMap()
        setupTimer()
    }
    
    
    // MARK: - API data methods
    
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
    
    
    // MARK: - View refreshing methods

    private func refreshView() {
        guard let issPosition = issPosition else { return }
        
        centerMap()
        changeAnnotationPointPosition()
        
        lastTimeLabel.text = Helper.getDateFromTimestamp(issPosition.timestamp)
        
        let position = String(format: "latitude: %@ / longitude: %@", issPosition.position.latitude, issPosition.position.longitude)
        lastPositionLabel.text = position
    }
    
    
    // MARK: - Timer methods
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            self?.getCurrentPosition()
        })
    }
    
    
    // MARK: - Map methods
    
    private func getPositionCoordinate() -> CLLocationCoordinate2D? {
        guard
            let issPosition = issPosition,
            let latitude  = Double(issPosition.position.latitude),
            let longitude = Double(issPosition.position.longitude)
            else {
                return CLLocationCoordinate2DMake(0, 0)
                //return nil
            }

        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    private func centerMap() {
        guard let coordinate = getPositionCoordinate() else { return }
        mapView.setCenter(coordinate, animated: true)
    }
    
    private func addPointAnnotationToMap() {
        guard let coordinate = getPositionCoordinate() else { return }
        
        mapPointAnnotation = MGLPointAnnotation()
        mapPointAnnotation.coordinate = coordinate
        mapPointAnnotation.title = "ISS"
        mapView.addAnnotation(mapPointAnnotation)
    }
    
    private func changeAnnotationPointPosition() {
        guard let coordinate = getPositionCoordinate() else { return }
        
        mapPointAnnotation.coordinate = coordinate
    }
}
