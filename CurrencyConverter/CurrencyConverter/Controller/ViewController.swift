//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Pranav Athavale on 22/03/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDataSource,CurrencyManagerDelegate{

 

    @IBOutlet weak var currencyAmount: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPickerOne: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    //  @IBOutlet weak var currencyPickerTwo: UIPickerView!
    
    var currencyManager = CurrencyManager()
    var parsedCurrencyNames: [String:Double] = ["":0.0]
//    var parsedCurrencyRates: Array = [0.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyManager.delegate = self
        currencyPickerOne.delegate = self
       // currencyPickerTwo.delegate = self
        currencyPickerOne.dataSource = self
        //currencyPickerTwo.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        let selectedCurrency = currencyManager.currencyArray[row]
        currencyManager.getCurrency(currency: selectedCurrency)
        
        
//       else if pickerView.tag == 2 {
//            let selectedConversionCurrency = currencyManager.currencyArray[row]
//            currencyManager.getConvertedCurrencyName(currencyName: selectedConversionCurrency)
//        }
    }
    
    func didUpdateRate(currentPrice: Double) {
        DispatchQueue.main.async {
            self.currencyAmount.text = String(currentPrice)
        }
    }
    
    func didUpdateCurrencyName(selectedCurrencyName: String) {
        DispatchQueue.main.async {
            self.currencyLabel.text = selectedCurrencyName
        }
    }
    
    
    
//    func parsedData(parsedCurrency: [String : Double]) {
//        DispatchQueue.main.async {
////            self.parsedCurrencyNames = Array(parsedCurrency.keys)
////            self.parsedCurrencyRates = Array(parsedCurrency.values)
////            print(self.parsedCurrencyNames)
////            print(self.parsedCurrencyRates)
//
//
//        }
//    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return parsedCurrencyNames.count
       
    }
    
//    func parsedC(parsedcn: String) {
//        DispatchQueue.main.async {
//            self.parsedCurrencyNames = parsedcn
//        }
//
//    }
    
//    func parsedV(parsedcv: Double) {
//
//    }
    func parsedData(parsedCurrency: [String:Double]) {
        parsedCurrencyNames = parsedCurrency
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as UITableViewCell
//        var key   = Array(self.parsedCurrencyNames.keys)[indexPath.row]
//        var value = Array(self.parsedCurrencyNames.values)[indexPath.row]
        
        let key   = (Array(self.parsedCurrencyNames.keys)[indexPath.row])
        let value = (Array(self.parsedCurrencyNames.values)[indexPath.row])
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = String(value)
                DispatchQueue.main.async {
                    tableView.reloadData()
                    tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        
        return cell
        
    }
    
}

