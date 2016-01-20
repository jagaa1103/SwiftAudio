//
//  ViewController.swift
//  SwiftAudio
//
//  Created by Enkhjargal Gansukh on 1/20/16.
//  Copyright © 2016 Enkhjargal Gansukh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    var playingFlag:Bool = false
    
    
    override func viewDidLoad() {
        self.loadAudio()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBtnClicked(sender: AnyObject) {
        if(playingFlag){
            playingFlag = false
            self.pauseAudio()
        }else{
            playingFlag = true
            self.playAudio()
        }
    }
    
    func loadAudio(){
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        let filePath = NSBundle.mainBundle().pathForResource("1chapter", ofType: "mp3")
        let fileUrl = NSURL(fileURLWithPath: filePath!)
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl)
        }catch{
            print("Error in loadAudio")
        }
        
    }
    
    func playAudio(){
        do{
            try audioPlayer.play()
        }catch{
            print("Error in PlayAudio")
        }
    }
    func pauseAudio(){
        do{
            try audioPlayer.pause()
        }catch{
            print("Error in PauseAudio")
        }
    }
    
    func stopAudio(){
        do{
            try audioPlayer.stop()
        }catch{
            print("Error in StopAudio")
        }
    }

}

