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
    var count = 3600
    
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
        
        // Decrease seconds
//        seconds -= 1
//        let test = String(format: "%4.f", seconds / 60)
//        //let minutes = (seconds  % 3600) % 60

        
        if count > 0 {
            
            // Create the properties for minutes and seconds
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            timerLabel.text = minutes + ":" + seconds
            count -= 1
            
        }
    
    }
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
    }
    
}

