//
//  ViewController.swift
//  BabySoundApp
//
//  Created by Lucas Dahl on 8/10/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Properties
    var timer:Timer?
    var count = 0
    var audioPlayer: AVAudioPlayer?
    var soundArray = ["sound files"]
    
    // IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var multipleSoundsSwitch: UISwitch!
    
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
    
    func buttonBorderSetup(button: UIButton) {
        
        // Set the border around the selected button
        if button.layer.borderWidth == 0 {
            
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 3
            
        } else if button.layer.borderWidth == 3 {
            
            button.layer.borderWidth = 0
            
        }
        
    }
    
    func playSound(_ note: String) {
        
        // Make a reference to the sound url
        let soundUrl = Bundle.main.url(forResource: note, withExtension: "file type")
        
        // Make sure the sound url is not nil
        guard soundUrl != nil else { return }
        
        do {
            
            // try playing the sound file
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
            
            // Actually play the sound
            audioPlayer?.play()
            
        } catch {
            
            // There was an error
            print("Error playing sound file: \(error)")
            
        }
        
    }
    
    func pickSound(_ button: UIButton) {
        
        // Get the selected button based on  its tag property, and use that tag - 1 to selcet the sound to play using the method.
        let selectedSound = soundArray[button.tag - 1]
        
        // Play the sound
        playSound(selectedSound)
        
    }
    
    //==============
    // End - Methods
    //==============
    
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        
        // Setup the timer
        setupTimer()
        
        if sender.tag == 1 {
            
            // The count for the timer
            count = 900
            // Set the label
            timerLabel.text = "15:00"
            
        } else if sender.tag == 2 {
            
            // The count for the timer
            count = 1800
            // Set the label
            timerLabel.text = "30:00"
            
        } else if sender.tag == 3 {
            
            // The count for the timer
            count = 2700
            // Set the label
            timerLabel.text = "45:00"
            
        } else if sender.tag == 4 {
            
            // The count for the timer
            count = 3600
            // Set the label
            timerLabel.text = "60:00"
            
        } else if sender.tag == 5 {
            
            // Stop the timer
            timer?.invalidate()
            // Set the label
            timerLabel.text = "00:00"
            
        }
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        
        // TODO: refactor, plus make the sounds stop playing if they are deslected
        
        
        // Check if the switch is on or not - plays multiple sounds
        if multipleSoundsSwitch.isOn == true  {
            
            // Set the button border
            buttonBorderSetup(button: sender)
            
        } else { // plays one sound
            
            // Check to see if any button has already been selected
            for button in buttonArray {
                
                if button.layer.borderWidth == 3 {
                    
                    button.layer.borderWidth = 0
                    
                    // Stop the sounds from being played
                    audioPlayer?.stop()
                    
                }
                
            }
            
            // Set the button border
            buttonBorderSetup(button: sender)
            
        }
        
        // Play the sound
        pickSound(sender)
        
    }
    
    @IBAction func stopSoundButton(_ sender: UIButton) {
        
        // hide all the borders
        for button in buttonArray {
            
            if button.layer.borderWidth == 3 {
                
                button.layer.borderWidth = 0
                // TODO: end the current sound? May need to be moved
                
            }
            
        }
        
        // Cencel the sound
        audioPlayer?.stop()
        
        // TODO: - Cancel the the timer
        
        
    }
    
    //================
    // End - IBActions
    //================
    
    
    
} // End class

