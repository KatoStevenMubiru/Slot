//
//  playSound.swift
//  Slot
//
//  Created by Kato Steven Mubiru on 27/01/2023.
//

import  AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound: String , type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }// do
        catch{
            print("ERRO : Couldn't find the sound")
        }
    }// if
    
}// func
