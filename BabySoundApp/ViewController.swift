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
        
        // Create the timer
        //TODO: - add timer to a method
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)

        // This allows the timer to work while scrolling
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
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
            // TODO: tunr off the sound
            
        }
    
    }
    
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        
        if sender.tag == 16 {
            
            count = 10
            
        } else if sender.tag == 30 {
            
            count = 1800
            
        } else if sender.tag == 45 {
            
            count = 2700
            
        } else if sender.tag == 60 {
            
            count = 3600
            
        } else if sender.tag == 61 {
            //TODO does not work
            // User wants no time limit
            timer?.invalidate()
            timerLabel.text = "00:00"
            
        }
        // DOesnt work
        if count > 0 {
            
            timer?.invalidate()// should bot be invalidate
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
    
    
} // End class

