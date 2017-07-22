//
//  IntervalWorkout.swift
//  JogRunSprint
//
//  Created by Kimberly Strauch on 2/4/17.
//

import Foundation

enum IntervalType {
    case warmup
    case jog
    case run
    case sprint
    case walk
    case cooldown
    case complete
}

struct Interval {
    let duration: Double
    let type: IntervalType
    let set: Int
    
    init(duration: Double, type: IntervalType, set: Int){
        self.duration = duration
        self.type = type
        self.set = set
    }
}

class IntervalWorkout {
    
    //MARK:Properties
    
    // warm up, pause, cooldown durations
    var warmupDuration = 120.0
    var cooldownDuration = 120.0
    var pauseDuration = 120.0
    
    // number of sets, and 30-20-10 intervals per set
    var numIntervalsPerSet = 4.0
    var numSets = 4.0
    
    // keep track of intervals, curr interval
    var intervalArray:[Interval] = []
    var isActive = false
    var currInterval = 0
    var timeRemaining = 0.0
    
    let intervalAudio = IntervalAudio()
    
    init(with settings: Settings?) {
        if let settings = settings {
            self.warmupDuration = settings.warmupDurationInMinutes * 60
            self.cooldownDuration = settings.cooldownDurationInMinutes * 60
            self.pauseDuration = settings.pauseDurationInMinutes * 60
            self.numIntervalsPerSet = settings.numberOfReps
            self.numSets = settings.numberOfSets
        }
        self.setupArray()
        self.reset()
    }
    
//    init(warmupDuration: Int?, cooldownDuration: Int?, pauseDuration: Int?, numIntervalsPerSet: Int?, numSets: Int?) {
//        self.warmupDuration = warmupDuration ?? 120
//        self.cooldownDuration = cooldownDuration ?? 120
//        self.pauseDuration = pauseDuration ?? 120
//        self.numIntervalsPerSet = numIntervalsPerSet ?? 4
//        self.numSets = numSets ?? 4
//        
//        self.setupArray()
//        self.reset()
//    }
    
    // call in initializer to set up the workout.
//    // call again whenever the user changes the settings so as to reset the workout
//    func updateWorkout(warmupDuration: Double?, cooldownDuration: Int?, pauseDuration: Int?, numIntervalsPerSet: Int?, numSets: Int?) {
//        self.warmupDuration = warmupDuration ?? 120.0
//        self.cooldownDuration = cooldownDuration ?? 120.0
//        self.pauseDuration = pauseDuration ?? 120.0
//        self.numIntervalsPerSet = numIntervalsPerSet ?? 4.0
//        self.numSets = numSets ?? 4.0
//    
//        self.setupArray()
//        self.reset()
//    }
//    
    
    //MARK: Methods
    func setupArray() {
        self.intervalArray = []
        intervalArray.append(Interval(duration: self.warmupDuration, type: IntervalType.warmup, set: 0))
        for i in 1...Int(numSets) {
            for _ in 0..<Int(numIntervalsPerSet) {
                // abstract out later :)
                intervalArray.append(Interval(duration: 30, type: IntervalType.jog, set: i))
                intervalArray.append(Interval(duration: 20, type: IntervalType.run, set: i))
                intervalArray.append(Interval(duration: 10, type: IntervalType.sprint, set: i))
            }
            if (i < Int(numSets)) {
                intervalArray.append(Interval(duration: self.pauseDuration, type: IntervalType.walk, set: i))
            }
        }
        intervalArray.append(Interval(duration: self.cooldownDuration, type: IntervalType.cooldown, set: Int(numSets)))
    }
    
    
    // to be called whenever the interval workout is starting up (for first time, or after a workout is stopped)
    func reset() {
        self.currInterval = 0
        self.timeRemaining = warmupDuration
    }
    
    func startOrResume() {
        self.isActive = true
    }
    
    func pause() {
        self.isActive = false
    }
    
    func stop() {
        self.isActive = false
        reset()
    }
    
    // returns false when unable to skip, i.e. we are at the end of the workout
    // otherwise returns true
    func skip() -> Bool {
        let couldAdvance = self.advance()
        if couldAdvance {
            self.timeRemaining = intervalArray[currInterval].duration + 1
            return true
        }
        return false
    }
    
    // returns false when unable to advance, i.e. we are at the end of the workout
    // otherwise returns true
    func advance() -> Bool {
        self.currInterval += 1
        if (currInterval == intervalArray.count) {
            return false
        }
        intervalAudio?.playBeep()
        self.timeRemaining = intervalArray[currInterval].duration
        return true
    }
    
    func tick() {
        if self.isActive {
            self.timeRemaining -= 1
            if (self.timeRemaining == 3) {
                intervalAudio?.playPrepSound(type: self.getNextIntervalType())
            }
            if (self.timeRemaining == 0) {
                let isDone = !self.advance()
                intervalAudio?.playBeep()
                if isDone {
                    self.stop()
                }
            }
        }
    }
    
    
    // methods for retrieving info about the current interval
    func getTimeRemaining() -> Int {
        return Int(self.timeRemaining)
    }
    
    // percentage of interval that we have left
    func percentageRemaining() -> Double {
        return (self.timeRemaining / self.intervalArray[currInterval].duration)
    }
    
    
    func getIntervalType() -> IntervalType {
        return self.intervalArray[currInterval].type
    }
    
    
    
    func getNextIntervalType() -> IntervalType {
        if currInterval < (intervalArray.count - 1) {
            return self.intervalArray[currInterval+1].type
        }
        return IntervalType.complete
    }
    
    func getIntervalSet() -> Int {
        return self.intervalArray[currInterval].set
    }
    
}
