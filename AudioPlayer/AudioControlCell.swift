//
//  AudioControlCell.swift
//  AudioPlayer
//
//  Created by اسرارالحق  on 08/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit
import AVFoundation

typealias Handler = () ->()
typealias Handler_Float = (Float)->()
typealias Handler_Int = (Int)->()

class AudioControlCell: UITableViewCell {
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var speedViewExtensionConstraint: NSLayoutConstraint!
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var speedButton: UIButton!
    @IBOutlet weak var speedViewCollapseButton: UIButton!
    
    var previousTrack: Handler?
    var playPause: Handler?
    var nextTrack: Handler?
    var volume: Handler_Float?
    var track: Handler_Float?
    var playerSpeed: Handler_Int?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.speedViewExtensionConstraint.constant = 0
        speedButton.layer.cornerRadius = speedButton.frame.size.height/2
        speedView.layer.cornerRadius = speedView.frame.size.height/2
        speedViewCollapseButton.isHidden = true
    }
    @IBAction func previousButtonTapped(_ sender: Any) {
        previousTrack?()
    }
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        playPause?()
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        nextTrack?()
    }
    @IBAction func didChangeTrackSlider(_ sender: UISlider) {
        track?(sender.value)
    }
    @IBAction func didChangeVolumeSlider(_ sender: UISlider) {
        volume?(sender.value)
    }
    @IBAction func speedButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.speedViewExtensionConstraint.constant == 0 {
                self.speedViewExtensionConstraint.constant = 300
                self.speedViewCollapseButton.isHidden = false
                self.layoutIfNeeded()
            } else {
                self.speedViewExtensionConstraint.constant = 0
                self.speedViewCollapseButton.isHidden = true
                self.layoutIfNeeded()
            }
            
        }
        
    }
    
    @IBAction func speedViewCollapseButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.speedViewExtensionConstraint.constant = 0
            self.speedViewCollapseButton.isHidden = true
            self.layoutIfNeeded()
        }
    }
    @IBAction func speedSelectButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            speedButton.setTitle("1.0x", for: .normal)
        case 1:
            speedButton.setTitle("1.25x", for: .normal)
        case 2:
            speedButton.setTitle("1.5x", for: .normal)
        case 3:
            speedButton.setTitle("1.75x", for: .normal)
        case -1:
            speedButton.setTitle("0.75x", for: .normal)
        case -2:
            speedButton.setTitle("0.5x", for: .normal)
        case -3:
            speedButton.setTitle("0.25x", for: .normal)
        default:
            speedButton.setTitle("1.0x", for: .normal)
        }
         playerSpeed?(sender.tag)
    }
    
    
    
}
