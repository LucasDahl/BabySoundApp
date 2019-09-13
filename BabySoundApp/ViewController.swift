//
//  ViewController.swift
//  BabySoundApp
//
//  Created by Lucas Dahl on 8/10/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//



import UIKit
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController {

    // Properties
    var timer:Timer?
    var count = 0
    var soundStopped: AVAudioPlayer?
    var multipleSounds: [AVAudioPlayer] = []
    var soundArray = ["babyMobileNoise", "wombNoise", "whiteNoise", "dryerNoise", "fanNoise", "hairdryerNoise", "carNoise", "airplaneNoise", "trainNoise", "oceanNoise", "natureNoise", "fireNoise", "stormNoise", "rainNoise", "showerNoise"]
    var adUintId = ""
    
    
    // IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var multipleSoundsSwitch: UISwitch!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet var timmerButtonArray: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the sounds when loading
        soundPlayerSetup()
        
        // Setup the timer
        setupTimer()
        
        // Setup the add banner
        // Banner ID
        bannerView.adUnitID = adUintId
        // Set the root view controller of the banner
        bannerView.rootViewController = self
        // Init the load request
        bannerView.load(GADRequest())
        
        // Set the delegate
        bannerView.delegate = self
        
    }
    
    
    //=======================
    // MARK: - Timer Methods
    //=======================
    
    // Setup up the timer when called
    func setupTimer() {
        
        if timer != nil {
            timer?.invalidate()
        }
        
        // Set the timer scheduled
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        // Set the timer tolerance
        timer?.tolerance = 1.9
        
        // This allows the timer to work while scrolling
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    // Objc timer method
    @objc func timerElapsed() {
        
        // Check to see if the count property is at zero
        if count > 0 {
            
            // Create the properties for minutes and seconds
            let minutes = (count) / 60
            let seconds = (count) % 60
            timerLabel.text = String(format: "%02i:%02i" , minutes, seconds)
            
            // Reduce the count by 1
            count -= 1
            
            // If the count( or time) is equal to zero 
            if count <= 0 {
                
                timerLabel.text = "00:00"
                
                // Stop the sound
                stopSounds()
                
                // Make sure the border turns off for selected buttons when the timer runs out
                for button in buttonArray {
                    
                    if button.layer.borderWidth == 3 && multipleSounds[button.tag - 1].isPlaying == false {
                        button.layer.borderWidth = 0
                    }
                    
                }
                
            }
            
        }
    
    }
    
    //==================
    // End Timer Methods
    //==================
    
    
    //====================
    // MARK: Sound Methods
    //====================
    
    // Stop all sounds
    func stopSounds() {
        
        for sound in multipleSounds {
            sound.stop()
        }
        
    }
    
    // Setup the sound player array
    func soundPlayerSetup() {
        
        do {
            
            for sound in soundArray {
                
                // Make a reference to the sound url
                let soundUrl = Bundle.main.url(forResource: sound, withExtension: "wav")
                
                // Make sure the sound url is not nil
                guard soundUrl != nil else { return }
                
                // Create the sound player
                let soundPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
                soundPlayer.numberOfLoops = -1
                soundPlayer.volume = 3
                multipleSounds.append(soundPlayer)
                
            }
            
        } catch {
            
            print("Error creating sound players: \(error)")
            
        }
        
        
    }
    
    // Play the sound picked
    func playSound(_ selectedSound: Int) {
        
        if multipleSoundsSwitch.isOn == false {

            stopSounds()

        }
        
        multipleSounds[selectedSound].play()

        do {
            
            // Allows for sound to be played while phone is locked and when at the home screen
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)


        } catch {

            print("Error playing sound file: \(error)")

        }

    }
    
    // Pick a sound to play
    func pickSound(_ button: UIButton) {
        
        // Get the selected button based on its tag property, and use that tag - 1 to selcet the sound to play using the method.
        let selectedSound = button.tag - 1

        // Play the sound
        playSound(selectedSound)
        
    }
    
    //==================
    // End Sound Methods
    //==================
    
    //=================
    // MARK: UI Methods
    //=================
    
    // Method to alter the button border
    func buttonBorderSetup(button: UIButton) {
        
        // Set the border around the selected button
        if button.layer.borderWidth == 0 {
            
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 3
            
        } else if button.layer.borderWidth == 3 {
            
            // stop only the deslected sound here
            if multipleSoundsSwitch.isOn == true {

                multipleSounds[button.tag - 1].stop()

            } else {

                stopSounds()

            }
            
            button.layer.borderWidth = 0
            
        }
        
    }
    
    //===============
    // End UI Methods
    //===============
    
    
    //==================
    // MARK: - IBActions
    //==================

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        
        // MAke only the selected button have a border
        for button in timmerButtonArray {
            
            if button.layer.borderWidth == 3 {
                button.layer.borderWidth = 0
            } else if button.tag == sender.tag {
                button.layer.borderWidth = 3
            }
            
        }
        
        // Setup the timer if any was invalidated
        if timer == nil {
            setupTimer()
        }
        
        if sender.tag == 1 {
            
            if count >= 1 && count <= 900 {
                return
            } else {
                count = 900
            }
            
        } else if sender.tag == 2 {
            
            if count >= 901 && count <= 1800 {
                return
            } else {
                count = 1800
            }
            
        } else if sender.tag == 3 {
            
            if count >= 1801 && count <= 2700 {
                return
            } else {
                count = 2700
            }
            
        } else if sender.tag == 4 {
            
            if count >= 2701 && count <= 3600 {
                return
            } else {
                count = 3600
            }
            
            
        } else if sender.tag == 5 {
            
            // Stop the timer
            timer?.invalidate()
            timer = nil
            
            // Set the label
            timerLabel.text = "00:00"
            
        }
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        
        // Check if the switch is on or not - plays multiple sounds
        if multipleSoundsSwitch.isOn == true  {
            
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

        // Cancel the timer and make it nil
        timer?.invalidate()
        timer = nil
        
    }
    
    //==================
    // End IBActions
    //==================
    
} // End class

//=============================
// MARK: - BannerView extension
//=============================

extension ViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("recived ad")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
    
} // End the extension
