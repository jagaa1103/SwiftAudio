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
    
    @IBOutlet weak var audioSlider: UISlider!
    
    @IBAction func sliderChanged(sender: AnyObject) {
        audioPlayer.currentTime = Double(audioSlider.value) * audioPlayer.duration
        NSLog("slider value = %f", audioSlider.value);
    }
    
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
    
    var updater : CADisplayLink! = nil
    func playAudio(){
            updater = CADisplayLink(target: self, selector: Selector("updateSliderProgress"))
            updater.frameInterval = 1
            updater.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            audioPlayer.play()
    }
    func pauseAudio(){
        audioPlayer.pause()
    }
    
    func stopAudio(){
        audioPlayer.stop()
        updater.invalidate()
    }
    
    func updateSliderProgress(){
        let progress = audioPlayer.currentTime / audioPlayer.duration
        audioSlider.setValue(Float(progress), animated: false)
    }

}

