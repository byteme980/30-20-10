//
//  ViewController.swift
//  JogRunSprint
//
//  Created by Kimberly Strauch on 2/4/17.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    //MARK:Properties
    var timer:Timer? = nil
    var intervalWorkout: IntervalWorkout
//    var intervalWorkout = IntervalWorkout()
    var isActive = false
    var player: AVPlayer?
    var queuePlayer: AVQueuePlayer?
    var settings: Settings?
    
    //MARK:Outlets
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var numSetLabel: UILabel!
    @IBOutlet weak var intervalTypeLabel: UILabel!
    
    @IBOutlet weak var startPauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    

    @IBOutlet weak var background: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasRunBefore") {
            let warmup = defaults.double(forKey: "warmup")
            let cooldown = defaults.double(forKey: "cooldown")
            let reps = defaults.double(forKey: "reps")
            let sets = defaults.double(forKey: "sets")
            let pause = defaults.double(forKey: "pause")
            
            self.settings = Settings(warmupDurationInMinutes: warmup, cooldownDurationInMinutes: cooldown, numberOfReps: reps, numberOfSets: sets, pauseDurationInMinutes: pause)
        } else {
            self.settings = nil
        }
        
        self.intervalWorkout = IntervalWorkout(with: self.settings)
        super.init(coder: aDecoder)

    }
    
    func setupFromUserDefaults() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasRunBefore") {
            let warmup = defaults.double(forKey: "warmup")
            let cooldown = defaults.double(forKey: "cooldown")
            let reps = defaults.double(forKey: "reps")
            let sets = defaults.double(forKey: "sets")
            let pause = defaults.double(forKey: "pause")
            
            settings = Settings(warmupDurationInMinutes: warmup, cooldownDurationInMinutes: cooldown, numberOfReps: reps, numberOfSets: sets, pauseDurationInMinutes: pause)
        } else {
            settings = nil
        }
        
        intervalWorkout = IntervalWorkout(with: settings)
    }
    
    //MARK:Actions
    @IBAction func startOrPause(_ sender: Any) {
        isActive = !isActive
        updateButtons()
        settingsButton.isEnabled = false
        
        // initialize the timer if not initialized yet...
        if isActive {
            intervalWorkout.startOrResume()
            if (timer == nil) {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
                //                playSound()
            }
        } else {
            intervalWorkout.pause()
        }
    }

    @IBAction func stop(_ sender: UIButton) {
        intervalWorkout.stop()
        if let t = timer {
            t.invalidate()
            timer = nil
        }
        isActive = false
        settingsButton.isEnabled = true
        updateUI()
    }
    
    @IBAction func skip(_ sender: UIButton) {
        // skipping should only be allowed when workout is active
        if isActive {
            let isDone = !intervalWorkout.skip()
            if(isDone) {
                timer?.invalidate()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        super.unwind(for: unwindSegue, towardsViewController: subsequentVC)
    }
    
    func counter() {
        intervalWorkout.tick()
        updateLabels()
    }
    
    func updateUI() {
        updateButtons()
        updateLabels()
    }
    
    func setupGradient() {
        let layer = CAGradientLayer()
        layer.frame = background!.bounds
 
        let topColor = UIColor(red:0.84, green:0.11, blue:0.56, alpha:1.0)
        let bottomColor = UIColor(red:1.00, green:0.58, blue:0.39, alpha:1.0)
    

        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        background!.layer.addSublayer(layer)
    }
    
    
    // set the button image to pause or start depending on current app state
    func updateButtons() {
        if (isActive) {
            startPauseBtn.setTitle("pause", for: .normal)
        } else {
            startPauseBtn.setTitle("start", for: .normal)
        }
    }
    
    func updateLabels() {
        secondsLabel.text = String(intervalWorkout.getTimeRemaining())
        intervalTypeLabel.text = "\(intervalWorkout.getIntervalType())"
        numSetLabel.text = "\(intervalWorkout.getIntervalSet())/\(Int(intervalWorkout.numSets))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupFromUserDefaults()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if let timer = timer {
            timer.invalidate()
        }
        // Dispose of any resources that can be recreated.
    }
}

