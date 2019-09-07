//
//  ViewController.swift
//  BabySoundApp
//
//  Created by Lucas Dahl on 8/10/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // Properties
    var timer:Timer?
    var count = 0
    var duplicatePlayers: [AVAudioPlayer] = []
    var soundArray = ["babyMobileNoise", "wombNoise", "whiteNoise", "dryerNoise", "fanNoise", "hairdryerNoise", "carNoise", "airplaneNoise", "trainNoise", "oceanNoise", "natureNoise", "fireNoise", "stormNoise", "rainNoise", "showerNoise"]
    
    
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
        // TODO: - fixed timer, it has a delay
        // Check to see if the count property is at zero
        if count > 0 {
            
            // Create the properties for minutes and seconds
            let minutes = String(count / 60)
            let seconds = String(format: ":%02i", (count % 60))
            timerLabel.text = minutes + seconds
            count -= 1
            
            if count <= 0 {
                
                timerLabel.text = "0:00"
                
                // Stop the sound
                stopSounds()
                
            }
            
        }
    
    }
    
    func stopSounds() {
        
        for sound in duplicatePlayers {
            sound.stop()
        }
        
    }
    
    func setupTimer() {
        
        // Invalidate any timers that are currently running.
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
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
            
            // Stop anysound that is being played - as a backup most likely will not be called
            stopSounds()
            
        }
        
    }
    
    func playSound(_ note: String) {
        
        // Make a reference to the sound url
        let soundUrl = Bundle.main.url(forResource: note, withExtension: "wav")
        
        // Make sure the sound url is not nil
        guard soundUrl != nil else { return }
        
        // Check to see if the user only wants to play one sound
        if multipleSoundsSwitch.isOn == false {
            
            stopSounds()
            
        }
        
        
        do {
            
            // Create the sound player
            let soundPlayer = try AVAudioPlayer( contentsOf: soundUrl! )
            soundPlayer.numberOfLoops = -1
            soundPlayer.volume = 1
            soundPlayer.play()
            
            // Check to see if the sound is already playing
            if !duplicatePlayers.contains(soundPlayer) {
                
                duplicatePlayers.append(soundPlayer)
                
            } else {
                return
            }
            
            
        } catch {
            
            print("Error playing sound file: \(error)")
            
        }

    }
    
    func pickSound(_ button: UIButton) {
        
        // Get the selected button based on its tag property, and use that tag - 1 to selcet the sound to play using the method.
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
            
        } else if sender.tag == 2 {
            
            // The count for the timer
            count = 1800
            
        } else if sender.tag == 3 {
            
            // The count for the timer
            count = 2700
            
        } else if sender.tag == 4 {
            
            // The count for the timer
            count = 3600
            
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
            //TODO: play multiple sounds
            
            // Play the sound
            pickSound(sender)

            // Set the button border
            buttonBorderSetup(button: sender)
            
        } else { // plays one sound
            
            // Check to see if any button has already been selected
            for button in buttonArray {
                
                if button.layer.borderWidth == 3 {
                    
                    button.layer.borderWidth = 0
                    
                    // Stop the sounds from being played
                    stopSounds()
                    
                }
                
            }
            
            // Play the sound
            pickSound(sender)
            
            // Set the button border
            buttonBorderSetup(button: sender)
            
        }
        
        
    }
    
    @IBAction func stopSoundButton(_ sender: UIButton) {
        
        // hide all the borders
        for button in buttonArray {
            
            if button.layer.borderWidth == 3 {
                
                button.layer.borderWidth = 0
                
            }
            
        }
        
        // Remove all sounds for the array to cancel them
        stopSounds()
        
        // Cancel the timer
        timer?.invalidate()
        
        
    }
    
    //================
    // End - IBActions
    //================
    
    
    
} // End class

