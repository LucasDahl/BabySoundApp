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
    var count = 0
    
    // IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var soundBeingPlayed: UILabel!
    @IBOutlet var buttonArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //================
    // MARK: - Methods
    //================
    
    @objc func timerElapsed() {
        
        // Check to see if the count property is at zero
        if count > 0 {
            
            // Create the properties for minutes and seconds
            let minutes = String(count / 60)
            let seconds = String(format: ":%02i", (count % 60))
            timerLabel.text = minutes + seconds
            count -= 1
            // TODO: turn off the sound
            
            if count <= 0 {
                
                //timer.
                timerLabel.text = "0:00"
                
            }
            
        }
    
    }
    
    func setupTimer() {
        
        // Invalidate any timers that are currently running.
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        // This allows the timer to work while scrolling
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        
        // Setup the timer
        setupTimer()
        
        if sender.tag == 1 {
            
            count = 900
            timerLabel.text = "15:00"
            
        } else if sender.tag == 2 {
            
            count = 1800
            timerLabel.text = "30:00"
            
        } else if sender.tag == 3 {
            
            count = 2700
            timerLabel.text = "45:00"
            
        } else if sender.tag == 4 {
            
            count = 3600
            timerLabel.text = "60:00"
            
        } else if sender.tag == 5 {
            
            timer?.invalidate()
            timerLabel.text = "00:00"
            
        }
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        
        // Check to see if any button has already been selected
        for button in buttonArray {
            
            if button.layer.borderWidth == 3 {
                
                button.layer.borderWidth = 0
                // TODO: end the current sound? May need to be moved
                
            }
            
        }
        
        // Set the border around the selected button
        if sender.layer.borderWidth == 0 {
            
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 3
            
        } else if sender.layer.borderWidth == 3 {
            
            sender.layer.borderWidth = 0
            
        }
        
        
    }
    
    @IBAction func stopSoundButton(_ sender: UIButton) {
        
        
    }
    
    
    
} // End class

