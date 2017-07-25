//
//  ViewController.swift
//  Scribe
//
//  Created by Admin on 24/07/2017.
//  Copyright © 2017 Mattowy. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeachAuthorization()
    }
}

extension MainVC {
    func requestSpeachAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    self.playRecording(path)
                    self.transcribeRecording(path)
                }
            }
        }
    }
    
    func playRecording(_ path: URL) {
        do {
            let sound = try AVAudioPlayer(contentsOf: path)
            self.audioPlayer = sound
            self.audioPlayer.delegate = self
            sound.play()
        } catch {
            print("Error!")
        }
    }
    
    func transcribeRecording(_ path: URL) {
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: path)
        recognizer?.recognitionTask(with: request) { (result, error) in
            if let error = error {
                print("There was an error: \(error)")
            } else {
                self.transcriptionTextField.text = result?.bestTranscription.formattedString
            }
        }
    }
    
}
