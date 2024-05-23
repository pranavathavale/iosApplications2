//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Pranav Athavale on 03/02/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//
import UIKit
import Foundation

struct CalculatorBrain {
    
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmiTo1Decimal = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1Decimal
        
    }
    
    mutating func calculateBMIValue(height: Float, weight: Float) {
        let bmiValue = weight / pow(2, height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "You are underweight", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        }
        
        else if bmiValue  < 25 {
            bmi = BMI(value: bmiValue, advice: "You are healthy", color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        }
        
        else{
            bmi = BMI(value: bmiValue, advice: "You are overweight", color: #colorLiteral(red: 0.6732690334, green: 0, blue: 0.08224309236, alpha: 1))
        }
        
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func  getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
/* Pranav's Code
    var bmi = "0.0"

   mutating func calculateBMI(height: Float, weight: Float) {

      bmi = String(format: "%.2f", weight / pow(2, height))

    }

    
    
    func getBMIValue() -> String {
        return bmi
    }
     */
}
