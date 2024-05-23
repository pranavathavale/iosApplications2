//
//  WeatherModel.swift
//  Clima
//
//  Created by Pranav Athavale on 16/02/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.moon.bolt.fill"
            
        case 300...399:
            return "cloud.drizzle.fill"
            
        case 500...599:
                return "cloud.rain.fill"
            
        case 600...699:
                return "cloud.snow.fill"
            
        case 700...799:
                return "sun.haze.fill"
        
        case 800...899:
                return "sun.max"
            
        default:
            return "cloud"
        }
    }
    
//    func getConditionName(weatherId: Int) -> String {
//        
//    }

}
