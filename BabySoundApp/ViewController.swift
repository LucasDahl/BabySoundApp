//
//  ViewController.swift
//  BabySoundApp
//
//  Created by Lucas Dahl on 8/10/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Properties
    var timer:Timer?
    var seconds = 3600
    
    // IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var soundSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        // This allows the timer to work while scrolling
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    //================
    // MARK: - Methods
    //================
    @objc func timerElapsed() {
        
        seconds -= 1
        
        // Set the label
        timerLabel.text = "\(seconds)"
        
        // When the timer has reached 0
        if seconds <= 0 {

            // Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red

        }
    
    }
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
    }
    
}

