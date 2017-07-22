//
//  SettingsViewController.swift
//  JogRunSprint
//
//  Created by Kimberly Strauch on 2/20/17.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var warmupStepper: UIStepper!
    @IBOutlet weak var cooldownStepper: UIStepper!
    @IBOutlet weak var repetitionsStepper: UIStepper!
    @IBOutlet weak var setsStepper: UIStepper!
    @IBOutlet weak var pauseStepper: UIStepper!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repetitionsLabel: UILabel!
    @IBOutlet weak var cooldownLabel: UILabel!
    @IBOutlet weak var warmupLabel: UILabel!
    
    func keyToStepperMap() -> [String: UIStepper] {
        return ["warmup": warmupStepper, "cooldown": cooldownStepper,
                "reps": repetitionsStepper, "sets": setsStepper,
                "pause": pauseStepper]
    }
    
    func keyToLabelMap() -> [String: UILabel]{
        return [
            "warmup": warmupLabel, "cooldown": cooldownLabel,
            "reps": repetitionsLabel, "sets": setsLabel,
            "pause": pauseLabel
        ]
    }

    
    var settings = Settings(warmupDurationInMinutes: 2, cooldownDurationInMinutes: 2, numberOfReps: 3, numberOfSets: 3, pauseDurationInMinutes: 2)
  
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        print("Stepper \(sender) did change to \(sender.value)")
        
        let str = String(Int(sender.value))
        
        var label: UILabel!
        switch(sender) {
            case warmupStepper:
                label = warmupLabel
                settings.warmupDurationInMinutes = sender.value
            case cooldownStepper:
                label = cooldownLabel
                settings.cooldownDurationInMinutes = sender.value
            case repetitionsStepper:
                label = repetitionsLabel
                settings.numberOfReps = sender.value
            case setsStepper:
                label = setsLabel
                settings.numberOfSets = sender.value
            case pauseStepper:
                label = pauseLabel
                settings.pauseDurationInMinutes = sender.value
            default:
                print("OOOPS")
        }
        
        label.text = str
        totalTimeLabel.text = "\(Int(settings.totalTime)) minutes"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFromDefaults()
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupFromDefaults() {
        let defaults = UserDefaults.standard
        // if it's not first run of app, set up settings view from user defaults :)
        if  defaults.bool(forKey: "hasRunBefore") {
            
            let keysToSteppers = keyToStepperMap()
            let keysToLabels = keyToLabelMap()
            
            for (key, stepper) in keysToSteppers {
                let val = defaults.double(forKey: key)
                stepper.value = val
                keysToLabels[key]?.text = "\(Int(val))"
            }
            
            //TODO: In future, make the Settings object conform to NSCoding protocol for serialization and deserialization :)... for now, this'll do
            settings = Settings(warmupDurationInMinutes: warmupStepper.value, cooldownDurationInMinutes: cooldownStepper.value, numberOfReps: repetitionsStepper.value, numberOfSets: setsStepper.value, pauseDurationInMinutes: pauseStepper.value)
            totalTimeLabel.text = "\(Int(settings.totalTime)) minutes"
        }
        
    }
    
    func saveToDefaults() {
        let defaults = UserDefaults.standard
        let map = keyToStepperMap()
        for (key,stepper) in map {
            defaults.set(stepper.value, forKey: key)
        }
        defaults.set(true, forKey: "hasRunBefore")
    }
    
    // save settings to user defaults
    override func viewWillDisappear(_ animated: Bool) {
        saveToDefaults()
        super.viewWillDisappear(true)
    }


}
