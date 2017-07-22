////
////  IntervalTimer.swift
////  JogRunSprint
////
////  Created by Kimberly Strauch on 2/4/17.
////  Copyright © 2017 Apple. All rights reserved.
////
//
//import Foundation
//
//class IntervalBatch {
//    var lowIntensityIntervalLength: Int
//    var midIntensityIntervalLength: Int
//    var highIntensityIntervalLength: Int
//    
//    var timeRemaining: Int
//    var currentIntervalInBatch = 0
//    
//    var batch:[Int]
//    
//    // returns false when done with the current batch
//    func next() -> Bool {
//        if currentIntervalInBatch == batch.count {
//            return false
//        }
//        currentIntervalInBatch += 1
//        timeRemaining = batch[currentIntervalInBatch]
//        return true
//    }
//    
//    // returns true, unless done with the current batch
//    func tick() -> Bool {
//       timeRemaining -= 1
//        if(timeRemaining == 0) {
//            let intervalsRemaining = next()
//            if (!intervalsRemaining) {
//                return false
//            }
//        }
//        return true
//    }
//    
//    
//    init(low: Int?, mid: Int?, high: Int?) {
//        self.lowIntensityIntervalLength = low ?? 30
//        self.midIntensityIntervalLength = mid ?? 20
//        self.highIntensityIntervalLength = high ?? 10
//        self.batch = [self.lowIntensityIntervalLength, self.midIntensityIntervalLength, self.highIntensityIntervalLength]
//        self.timeRemaining = self.batch[0]
//    }
//}
//
//
//
//// a set of interval batches
//// default number of interval batches per set = 3
//class IntervalSet {
//    var numIntervalsPerSet: Int
//    var intervalBatchArray: [IntervalBatch] = []
//    var highIntensityDuration = 30
//    
//    var currentIntervalBatch = 0
//    var setId: Int
//    
//    init(numIntervalsPerSet: Int?, highIntensityDuration: Int?, midIntensityDuration: Int?, lowIntensityDuration: Int?, setId: Int?) {
//        self.numIntervalsPerSet = numIntervalsPerSet ?? 3
//        
//        for _ in 0..<self.numIntervalsPerSet {
//            let newIntervalBatch = IntervalBatch(low: lowIntensityDuration, mid: midIntensityDuration, high: highIntensityDuration)
//            
//            self.intervalBatchArray.append(newIntervalBatch)
//        }
//        self.setId = setId ?? 0
//    }
//    
//    func next() -> Bool {
//        currentIntervalBatch += 1
//        if (currentIntervalBatch == numIntervalsPerSet) {
//            return false
//        }
//        return true
//    }
//    
//    // return false when set is done...
//    func tick() -> Bool {
//        let doneWithIntervalBatch = intervalBatchArray[currentIntervalBatch].tick()
//        
//        if (doneWithIntervalBatch) {
//            let doneWithSet = !next()
//            if (doneWithSet) {
//                return false
//            }
//        }
//        return true
//    }
//}
//
//// interval workouts, a series of Sets + pauses, cool down and warm up time 
//class IntervalWorkout {
//    // units are seconds
//    var warmupDuration: Int
//    var cooldownDuration: Int
//    var pauseDuration: Int
//    
//    var numIntervalsPerSet: Int
//    
//    var numSets: Int
//    
//    var highIntensityDuration: Int
//    var midIntensityDuration: Int
//    var lowIntensityDuration: Int
//
//    var intervalSetArray: [IntervalSet] = []
//    var currentSet = 0
//    var workoutArray = []
//    
//    init(warmupDuration:Int?, cooldownDuration: Int?, pauseDuration: Int?, numSets: Int?, highIntensityDuration: Int?, midIntensityDuration: Int?, lowIntensityDuration: Int?, numIntervalsPerSet: Int?) {
//        
//        // default 120 secs for warmup, cooldown, pause
//        self.warmupDuration = warmupDuration ?? 120
//        self.cooldownDuration = cooldownDuration ?? 120
//        self.pauseDuration = pauseDuration ?? 120
//        
//        // default 3 sets
//        self.numSets = numSets ?? 3
//        
//        // default 4 interval batches per set 
//        self.numIntervalsPerSet = numIntervalsPerSet ?? 4
//            
//        // default 30 20 10 for interval durations
//        self.lowIntensityDuration = lowIntensityDuration ?? 30
//        self.midIntensityDuration = midIntensityDuration ?? 20
//        self.highIntensityDuration = highIntensityDuration ?? 10
//        
//        for i in 0..<numSets {
//            let newSet = IntervalSet(numIntervalsPerSet: self.numIntervalsPerSet, highIntensityDuration: self.highIntensityDuration, midIntensityDuration: self.midIntensityDuration, lowIntensityDuration: self.lowIntensityDuration)
//        }
//    }
//    
//    func tick() {
//        
//    }
//    
//    func next() {
//
//    }
//}
//
//
///*
//class IntervalTimer {
//    var currentSet = 0
//    var currentIntervalWithinSet = 0
//
//    var numSets = 5
//    var intervalsWithinSet = 4
//
//    // all units are in seconds
//    var highIntensityIntervalTime = 30
////    var midIntensityIntervalTime = 20
//    var lowIntensityIntervalTime = 10
//    
//    var warmupTime = 120
//    var coolDownTime = 120
//    
//    
////    var sets = [[warmupTime] , intervals, [coolDownTime]
//    func setUpIntervalArray() {
//        intervalArray[0] = [[warmupTime]]
//        for i in 1...numSets {
//            for j in 0..<intervalsWithinSet {
//                intervalArray[i][j] = intervalLengths
//            }
//        }
//        intervalArray[numSets+1] = [[coolDownTime]]
//    }
//    
//}
//*/
