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
    
    private let timeInterval: Double = 5.0
    private var mapPointAnnotation: MGLPointAnnotation!
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.shared.loadSavedIssPosition {
            self.addPointAnnotationToMap()
            self.refreshView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCurrentPosition()
        
        DataManager.shared.getIssCrew()
        setupTimer()
    }
    
    // MARK: - View refreshing methods

    private func refreshView() {
        lastTimeLabel.text = DataManager.shared.getLastISSPositionTime()
        lastPositionLabel.text = DataManager.shared.getLastISSPositionCoordinateString()
        
        centerMap()
        changeAnnotationPointPosition()
    }
    
    
    // MARK: - Timer methods
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            self?.getCurrentPosition()
        })
    }
    
    private func getCurrentPosition() {
        DataManager.shared.getCurrentIssPosition {
            DispatchQueue.main.async {
                self.refreshView()
            }
        }
    }
    
    // MARK: - Map methods
    
    private func centerMap() {
        guard let coordinate = DataManager.shared.getLastISSPositionCoordinate() else { return }
        mapView.setCenter(coordinate, animated: true)
    }
    
    private func addPointAnnotationToMap() {
        guard let coordinate = DataManager.shared.getLastISSPositionCoordinate() else { return }
        
        mapPointAnnotation = MGLPointAnnotation()
        mapPointAnnotation.coordinate = coordinate
        mapPointAnnotation.title = "ISS"
        mapView.addAnnotation(mapPointAnnotation)
    }
    
    private func changeAnnotationPointPosition() {
        if mapPointAnnotation == nil {
            addPointAnnotationToMap()
        }
        
        guard
            let mapPointAnnotation = mapPointAnnotation,
            let coordinate = DataManager.shared.getLastISSPositionCoordinate() else { return }
        mapPointAnnotation.coordinate = coordinate
    }
}
