//
//  AudioControlCell.swift
//  AudioPlayer
//
//  Created by اسرارالحق  on 08/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

typealias Handler = () ->()
typealias Handler_Float = (Float)->()

class AudioControlCell: UITableViewCell {

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    
    var previousTrack: Handler?
    var playPause: Handler?
    var nextTrack: Handler?
    var volume: Handler_Float?
    var track: Handler_Float?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    

}
