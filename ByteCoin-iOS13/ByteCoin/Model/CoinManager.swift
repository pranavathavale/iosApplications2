//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(currentPrice: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8CE48CBE-73F7-4FBB-ABD0-29DF1037D6BC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)  {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                   // let dataString = String(data: safeData, encoding: .utf8)
                    let currentRate = parseJSON(safeData)
                    let priceString = String(format: "%.3f", currentRate!)
                    delegate?.didUpdateRate(currentPrice: priceString)

                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
       
        do {
         let decodedData =  try decoder.decode(CoinData.self, from: data)
            let currentRate = decodedData.rate
            return currentRate
           
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
