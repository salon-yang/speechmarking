//AudioPlayer.swift

//Created by BLCKBIRDS on 29.10.19.
//Visit www.BLCKBIRDS.com for more.

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback (audio: URL,atTime : Double) {

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                audioPlayer = try AVAudioPlayer(contentsOf: audio, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let audioPlayer = audioPlayer else { return }

                audioPlayer.play()

            } catch let error {
                print(error.localizedDescription)
            }
        
//        do {
//            //audioPlayer = try AVAudioPlayer(data: data)//data方式读取
//
//            audioPlayer = try AVAudioPlayer(contentsOf: audio)//URL方式读取
//            audioPlayer.delegate = self
////            if(atTime == 0.0){
//            audioPlayer.play()
////            }else{
////                audioPlayer.play(atTime: atTime)
////            }
//            isPlaying = true
//            //print("isPlaying！")
//        } catch {
//            print("Playback failed.")
//        }
    }
    
    func pausePlayback(){
        audioPlayer.pause()
        isPlaying = false
    }
    
    func restartPlayback(atTime:Double){
        audioPlayer.play(atTime: atTime)
        isPlaying = true
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
    
}
