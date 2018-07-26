//
//  MapAnnotationView.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 21.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Mapbox

class MapAnnotationView: MGLAnnotationView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 85, height: 85)
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.withAlphaComponent(0.2).cgColor
        self.layer.contents = UIImage(named: "ISSicon")!.cgImage
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
