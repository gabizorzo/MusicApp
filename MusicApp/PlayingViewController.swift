//
//  PlayingViewController.swift
//  MusicApp
//
//  Created by Gabriela Zorzo on 22/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var currentTime: UILabel!
    
    
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var statusBar: UISlider!
    
    @IBAction func statusBarUpdate(_ sender: UISlider) {
    }
    
    @IBOutlet weak var playButton: UIImageView!
    
    @IBOutlet weak var nextButton: UIImageView!
    
    @IBOutlet weak var prevButton: UIImageView!
    
    var music: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.isUserInteractionEnabled = true
        playButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playTapped(tapGestureRecognizer:))))
        
        nextButton.isUserInteractionEnabled = true
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextTapped(tapGestureRecognizer:))))
        
        prevButton.isUserInteractionEnabled = true
        prevButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prevTapped(tapGestureRecognizer:))))
        
        coverImage.image = UIImage(named: music?.id ?? "0")
        songNameLabel.text = music?.title
        artistLabel.text = music?.artist
        currentTime.text = "0:00"
        totalTime.text = "\(music?.length.minute ?? 0):\(music?.length.second ?? 0)"
        
        statusBar.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        statusBar.setThumbImage(UIImage(systemName: "circle.fill"), for: .highlighted)
        
    }
    
    @objc func playTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        print("play")
    }
    
    @objc func  nextTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        print("next")
    }
    
    @objc func  prevTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        print("prev")
    }
    
}

extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
