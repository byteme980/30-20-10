//
//  IntervalAudio.swift
//  JogRunSprint
//
//  Created by Kimberly Strauch on 2/19/17.
//

import Foundation
import AVFoundation
import AVKit


class IntervalAudio {
//    let runSound, jogSound, sprintSound: URL?
    let sounds: [IntervalType: URL]
    let beep: URL
    let player : AVPlayer
    var item: AVPlayerItem
    
    init?() {
        if let runSound = Bundle.main.url(forResource: "prepareToRun", withExtension: "aiff"),
        let jogSound = Bundle.main.url(forResource: "prepareToJog", withExtension: "aiff"),
        let sprintSound = Bundle.main.url(forResource: "prepareToSprint", withExtension: "aiff"),
        let cooldownSound = Bundle.main.url(forResource: "prepareToCooldown", withExtension: "aiff"),
        let pauseSound = Bundle.main.url(forResource: "prepareToPause", withExtension: "aiff"),
        let completeSound = Bundle.main.url(forResource: "workoutComplete", withExtension: "aiff"),
        let beepSound = Bundle.main.url(forResource: "beep", withExtension: "mp3") {
            
            sounds = [IntervalType.run: runSound, IntervalType.jog: jogSound, IntervalType.sprint: sprintSound, IntervalType.cooldown: cooldownSound, IntervalType.walk: pauseSound,
                IntervalType.complete: completeSound]
            beep = beepSound
            
            item = AVPlayerItem(url: sounds[IntervalType.jog]!)
            player = AVPlayer.init(playerItem: item)
            
        } else {
            return nil
        }

    }
    
    func playPrepSound(type: IntervalType) {
        player.replaceCurrentItem(with: AVPlayerItem(url: sounds[type]!))
        player.play()
    }
    
    func playBeep() {
        player.replaceCurrentItem(with: AVPlayerItem(url: beep))
        player.play()
    }
    
}
