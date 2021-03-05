//
//  ViewController.swift
//  Bleep
//
//  Created by Shahid Ghafoor on 05/03/2021.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sound = Bundle.main.path(forResource: "beep", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
    }

    
    @IBAction func playBeep(_ sender: Any) {
        audioPlayer?.play()
    }
    
}

