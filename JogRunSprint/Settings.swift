//
//  Settings.swift
//  JogRunSprDouble
//
//  Created by Kimberly Strauch on 2/23/17.
//

import Foundation

class Settings {
    var warmupDurationInMinutes: Double
    var cooldownDurationInMinutes: Double
    var numberOfReps: Double
    var numberOfSets: Double
    var pauseDurationInMinutes: Double
    var totalTime: Double {
        get {
            // since each rep is 1 minute long (30s + 20s + 10s), this calculation is simplified
            let activeMinutes = numberOfReps * numberOfSets
            let minutesPausing = pauseDurationInMinutes * (numberOfSets - 1)
            // total workout time = warmup + active time + pause time + cooldown
            return warmupDurationInMinutes + activeMinutes + minutesPausing + cooldownDurationInMinutes
        }
    }
    
    init(warmupDurationInMinutes: Double, cooldownDurationInMinutes: Double, numberOfReps: Double, numberOfSets: Double, pauseDurationInMinutes: Double) {
        self.warmupDurationInMinutes = warmupDurationInMinutes
        self.cooldownDurationInMinutes = cooldownDurationInMinutes
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.pauseDurationInMinutes = pauseDurationInMinutes
    }
 }

