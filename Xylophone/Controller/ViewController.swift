//
//  ViewController.swift
//  Xylophone
//
//  Created by Zhangali Pernebayev on 06.10.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var buttons: UIButton!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        buttons.alpha = 1.0
//        
//        buttons.addTarget(self, action: #selector(buttonTouchDown), for: .touchUpInside)
//        buttons.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
//        buttons.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("\(sender.title(for: .normal)!) button was tapped")
        playSound(fileName: sender.title(for: .normal)!)
        
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            sender.alpha = 1.0
        }
    }
    
//    @objc func buttonTouchDown() {
//        // Animate opacity change when button is clicked
//        UIView.animate(withDuration: 0.5) {
//            self.buttons.alpha = 0.5
//        }
//    }
//    
//    // Method called when button is released or touch is cancelled
//    @objc func buttonTouchUp() {
//        // Animate opacity change when button is released
//        UIView.animate(withDuration: 0.5) {
//            self.buttons.alpha = 1.0
//        }
//    }
    
    func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
