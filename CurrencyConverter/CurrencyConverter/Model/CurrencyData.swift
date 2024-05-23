//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Pranav Athavale on 22/03/21.
//

import Foundation
 

struct CurrencyData: Codable {
    let base_code: String
    let conversion_rates: [String:Double]
}

//struct Conversion_rates: Codable {
//
//}
