//
//  MapView.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 25.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit
import Mapbox

class MapView: MGLMapView {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0) {
        didSet {
            centerMap()
            changeAnnotationPointPosition()
        }
    }
    
    var crewString: String = ""
    
    
    lazy private var mapAnnotationPoint: MGLPointAnnotation = {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "ISS Crew"
        return annotation
    }()
    private var isAnnotationPointVisible = false


    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.allowsRotating = false
        self.allowsTilting = false
        
        self.delegate = self
    }
    
    func centerMap(withAnimation animation: Bool = true) {
        self.setCenter(coordinate, animated: animation)
    }
    
    func changeAnnotationPointPosition() {
        mapAnnotationPoint.coordinate = coordinate
        if !isAnnotationPointVisible { addAnnotationPointToMap() }
    }
    
    private func addAnnotationPointToMap() {
        self.addAnnotation(mapAnnotationPoint)
        isAnnotationPointVisible = true
    }
}

extension MapView: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        mapAnnotationPoint.subtitle = crewString
        return true
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return MapAnnotationView(reuseIdentifier: "ISSicon")
    }
}
