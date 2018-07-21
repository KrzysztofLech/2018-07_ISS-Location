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
    
    
    // MARK: - Properties
    
    private let timeInterval: Double = 5.0
    lazy private var mapAnnotationPoint: MGLPointAnnotation = {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = DataManager.shared.getLastISSPositionCoordinate()
        annotation.title = "ISS Crew"
        return annotation
    }()
    private var isAnnotationPointVisible = false
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLabelsColorActive(false)
        
        if DataManager.shared.issPosition == nil {
            getCurrentPosition()
        } else {
            refreshView()
            getCurrentPosition()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataManager.shared.getIssCrew()
        setupTimer()
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
                self.setLabelsColorActive(true)
                self.refreshView()
            }
        }
    }
    
    
    // MARK: - View refreshing methods
    
    private func setLabelsColorActive(_ active: Bool) {
        lastTimeLabel.alpha     = active ? 1.0 : 0.3
        lastPositionLabel.alpha = active ? 1.0 : 0.3
    }
    
    private func refreshView() {
        lastTimeLabel.text = DataManager.shared.getLastISSPositionTime()
        lastPositionLabel.text = DataManager.shared.getLastISSPositionCoordinateString()
        
        centerMap()
        changeAnnotationPointPosition()
    }
    
    
    // MARK: - Map methods
    
    private func centerMap(withAnimation: Bool = true) {
        let coordinate = DataManager.shared.getLastISSPositionCoordinate()
        mapView.setCenter(coordinate, animated: withAnimation)
    }
    
    private func changeAnnotationPointPosition() {
        mapAnnotationPoint.coordinate = DataManager.shared.getLastISSPositionCoordinate()
        if !isAnnotationPointVisible { addAnnotationPointToMap() }
    }
    
    private func addAnnotationPointToMap() {
        mapView.addAnnotation(mapAnnotationPoint)
        isAnnotationPointVisible = true
    }
}


// MARK: - Map delegate methods

extension ViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        mapAnnotationPoint.subtitle = DataManager.shared.getIssCrewString()
        return true
    }
}
