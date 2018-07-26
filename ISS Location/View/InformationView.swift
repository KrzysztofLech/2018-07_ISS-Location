//
//  InformationView.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 25.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class InformationView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!

    @IBInspectable private var title: String = ""
    
    var currentData: Bool = false {
        didSet {
            if currentData {
                labelAlphaAnimation()
            } else {
                informationLabel.alpha = 0.3
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = title
        informationLabel.text = "no data"
    }
    
    func showInformation(_ text: String) {
        informationLabel.text = text
    }
    
    private func labelAlphaAnimation() {
        informationLabel.alpha = 1.0
        UIView.animate(withDuration: positionRefreshingTimeInterval) {
            self.informationLabel.alpha = 0.3
        }
    }
}
