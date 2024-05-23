//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Pranav Athavale on 22/03/21.
//

import Foundation


protocol CurrencyManagerDelegate {
    func didUpdateCurrencyName(selectedCurrencyName: String)
    func didUpdateRate(currentPrice: Double)
    func didFailWithError(error: Error)
    func parsedData(parsedCurrency:[String:Double])
    //func parsedC(parsedcn: String)
   // func parsedV(parsedcv: Double)
}

struct CurrencyManager {
    
    let baseURL = "https://v6.exchangerate-api.com/v6/590858245d5eea33f714ba0e/latest/"
    
    let currencyArray = ["INR","AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM",
                         "BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTN","BWP",
                         "BYN","BZD","CAD","CDF","CHF","CLP","CNY","COP","CRC","CUC","CUP","CVE",
                         "CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","FOK",
                         "GBP","GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK",
                         "HTG","HUF","IDR","ILS","IMP","IQD","IRR","ISK","JMD","JOD","JPY","KES",
                         "KGS","KHR","KID","KMF","KRW","KWD","KYD","KZT","LAK","LBP","LKR","LRD",
                         "LSL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRU","MUR","MVR",
                         "MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB",
                         "PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RWF","SAR",
                         "SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","SSP","STN","SYP",
                         "SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TVD","TWD","TZS","UAH",
                         "UGX","USD","UYU","UZS","VES","VND","VUV","WST","XAF","XCD","XDR","XOF",
                         "XPF","YER","ZAR","ZMW"]
    
    var delegate: CurrencyManagerDelegate?
    
//    var ccn: String?
//    mutating func getConvertedCurrencyName(currencyName: String) {
//    ccn = "\(currencyName)"
//    }
    
    
     func getCurrency(currency: String) {
        let urlString = "\(baseURL)\(currency)"
        performRequest(urlString: urlString)
    }
    
    
     func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else{
                    if let safedata = data{
                      let currencySelected = parseJSON(currencyData: safedata)
                        if let priceString = currencySelected.1 {
                            delegate?.didUpdateRate(currentPrice: priceString)
                        }
                        
                        if let selectedCurrencyName = currencySelected.0 {
                            delegate?.didUpdateCurrencyName(selectedCurrencyName: selectedCurrencyName)
                        }
                        
                        if let parsedCurrencyData = currencySelected.2 {
                               delegate?.parsedData(parsedCurrency: parsedCurrencyData)
//                            for (key,value) in parsedCurrencyData {
//                                delegate?.parsedC(parsedcn: key)
//                                delegate?.parsedV(parsedcv: value)
//                            }
                              //  print(value)
                        }
                      
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(currencyData: Data) -> (String?,Double?,[String:Double]?) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
//            print(decodedData.conversion_rates)
            //let decoded = decodedData.base_code
            let selectedCurrencyName = decodedData.base_code
            let selectedCurrency = decodedData.conversion_rates[decodedData.base_code]
            let parsedData = decodedData.conversion_rates
           // print(parsedData)
//            let convertedCurrencyValue = decodedData.conversion_rates[ccn ?? ""]
            return (selectedCurrencyName, selectedCurrency, parsedData)
        }
        catch{
            return ("",nil,nil)
        }
    }

}

