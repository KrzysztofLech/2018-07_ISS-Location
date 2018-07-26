//
//  APIService.swift
//  ISS Location
//
//  Created by Krzysztof Lech on 25.07.2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import Foundation
import Alamofire

struct APIService {
    
    private let issPositionUrl = "http://api.open-notify.org/iss-now.json"
    private let issCrewUrl     = "http://api.open-notify.org/astros.json"
    
    func getIssPositionData(closure: @escaping (_ data: IssPosition) -> ()) {
        guard let endPointUrl = URL(string: issPositionUrl) else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseData { (dataResponse) in
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let apiData = try decoder.decode(IssPosition.self, from: data)
                    closure(apiData)
                } catch {
                    print("Decode error: ", error)
                }
        }
    }
    
    func getIssCrewData(closure: @escaping (_ data: [CrewMan]) -> ()) {
        guard let endPointUrl = URL(string: issCrewUrl) else {
            print("Error: Cannot create URL")
            return
        }
        
        Alamofire.request(endPointUrl)
            .responseJSON { (dataResponse) in
                guard
                    let apiData = dataResponse.result.value as? [String : Any],
                    let crewDictionary = apiData["people"] as? [[String : String]]
                    else { return }
                
                var crewArray = [CrewMan]()
                for item in crewDictionary {
                    if let name = item["name"] {
                        crewArray.append(CrewMan(name: name))
                    }
                }
                closure(crewArray)
        }
    }
}
