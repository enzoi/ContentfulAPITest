//
//  Plant.swift
//  ContentfulAPITest
//
//  Created by Yeontae Kim on 3/7/18.
//  Copyright © 2018 YTK. All rights reserved.
//

import Foundation


struct Plant {
    
    var scientificName: String
    var commonName: String
    var plantDescription: String?
    var latitude: Double
    var longitude: Double
    var plantType: String
    var climateZones: String
    var sunExposure: String
    var waterNeeds: String
    
    init(dictionary: [String: AnyObject]) {
        
        let scientificName = dictionary["scientificName"] as! String
        let commonNames = dictionary["commonName"] as! String
        let plantDescription = dictionary["plantDescription"] as? String
        let plantType = dictionary["plantType"] as! String
        let climateZones = dictionary["climateZones"] as! String
        let sunExposure = dictionary["sunExposure"] as! String
        let waterNeeds = dictionary["waterNeeds"] as! String
        let latitude = dictionary["latitude"] as! Double
        let longitude = dictionary["longitude"] as! Double
        
        self.scientificName = scientificName
        self.commonName = commonNames
        self.plantDescription = plantDescription ?? nil
        self.latitude = latitude
        self.longitude = longitude
        self.plantType = plantType
        self.climateZones = climateZones
        self.sunExposure = sunExposure
        self.waterNeeds = waterNeeds
    }
    
}
