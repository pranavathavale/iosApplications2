//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    //var secondsRemaining = 10
    var player: AVAudioPlayer!

    let eggTimes = ["Soft":5, "Medium":7, "Hard":12 ]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
//    let softTime = 5
//    let mediumTime = 7
//    let hardTime = 12
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
    
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        
        secondsPassed = 0
        
        titleLabel.text = hardness
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
    @objc func updateTimer() {
        
        if secondsPassed < totalTime {
            secondsPassed += 1
         let percentageProgress = Float(secondsPassed) / Float(totalTime)
         progressBar.progress = Float(percentageProgress)
             
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
            
        }
        
    }
}
