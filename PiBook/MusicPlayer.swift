//
//  MusicPlayer.swift
//  PiBook
//
//  Created by Kanta on 2026/05/26.
//


import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func startBackgroundMusic(fileName: String, type: String) {
        if audioPlayer != nil { return }
        if let bundlePath = Bundle.main.path(forResource: fileName, ofType: type) {
            let url = URL(fileURLWithPath: bundlePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 0.01
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("BGM Error: \(error)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
