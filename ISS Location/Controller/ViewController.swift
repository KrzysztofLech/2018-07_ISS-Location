//
//  ViewController.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 20.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

let positionRefreshingTimeInterval: Double = 5.0

class ViewController: UIViewController {
    
    @IBOutlet weak var timeView: InformationView!
    @IBOutlet weak var positionView: InformationView!
    @IBOutlet weak var mapView: MapView!
    
    lazy var viewModel: ViewModel = {
        return ViewModel()
    }()

    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.issPosition == nil {
            getCurrentPosition()
        } else {
            refreshView()
            getCurrentPosition()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getIssCrew {
            self.mapView.crewString = self.viewModel.issCrewString
        }
        setupTimer()
    }
    
    private func initView() {
        setInformationLabelsActive(false)
    }
    
    private func initViewModel() {
        viewModel.getLastSessionSavedPosition()
    }
    
    
    // MARK: - Timer methods
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: positionRefreshingTimeInterval, repeats: true, block: { [weak self] _ in
            self?.getCurrentPosition()
        })
    }
    
    private func getCurrentPosition() {
        viewModel.getCurrentIssPosition { [weak self] in
            self?.setInformationLabelsActive(true)
            self?.refreshView()
        }
    }
    
    
    // MARK: - View methods
    
    private func setInformationLabelsActive(_ active: Bool) {
        timeView.currentData = active
        positionView.currentData = active
    }
    
    private func refreshView() {
        timeView.showInformation(viewModel.timeText)
        positionView.showInformation(viewModel.positionText)
        mapView.coordinate = viewModel.issPositionCoordinate
    }
}
