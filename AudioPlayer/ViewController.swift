//
//  ViewController.swift
//  AudioPlayer
//
//  Created by اسرارالحق  on 08/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var controlCell: Int?
    var surahList: [Surah] = []
    var player: AVAudioPlayer?
    var volume: Float = 0.5
    var audioSlider: UISlider?
    var titleLabel: UILabel?
    var currentTimeLabel: UILabel?
    var totalTimeLabel: UILabel?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        prepareSurahList()
    }
    
    func prepareSurahList() {
        surahList.append(Surah(SurahTitle: "Al Imran", trackName: "Surah1"))
        surahList.append(Surah(SurahTitle: "Al Mulk", trackName: "Surah2"))
        surahList.append(Surah(SurahTitle: "Al Muzzamil", trackName: "Surah3"))
        surahList.append(Surah(SurahTitle: "Drood Sharif", trackName: "Surah4"))
        surahList.append(Surah(SurahTitle: "Al Haqa", trackName: "Surah5"))
        surahList.append(Surah(SurahTitle: "Al Mulk", trackName: "Surah6"))
        surahList.append(Surah(SurahTitle: "Al Rahman", trackName: "Surah7"))
    }
    
    func configure(){
        let surah = surahList[controlCell!]
        let urlString = Bundle.main.path(forResource: surah.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else { print("urlstring is nil");return }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else { print("Player is nil"); return }
            
            player.prepareToPlay()
            player.enableRate = true
            player.volume = self.volume
            startPlayer()
            
        }
        catch {
            print("error occurred")
        }
    }
    
    func startPlayer() {
        player!.play()
        if let audioSlider = audioSlider {
            audioSlider.value = 0.0
            audioSlider.maximumValue = Float((player?.duration)!)
        }
        else
        {
            print("audioSlider is nil")
        }
        timer = Timer.scheduledTimer(timeInterval: 0.0001,
                                     target: self,
                                     selector: #selector(self.updateSlider),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc func updateSlider(){
        audioSlider!.value = Float(player!.currentTime)
        currentTimeLabel?.text = convertTime(value: Int(player!.currentTime))
        totalTimeLabel?.text = convertTime(value: Int(player!.duration))
    }
    
    func convertTime (value : Int) -> String {
//      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let hour = value/3600
        let minute = (value % 3600) / 60
        let second = (value % 3600) % 60
        let h:String = hour<10 ? "0\(hour)" : "\(hour)"
        let m:String = minute<10 ? "0\(minute)" : "\(minute)"
        let s:String = second<10 ? "0\(second)" : "\(second)"
        if hour == 0 && minute == 0{
            return "\(s)"
        } else if hour == 0 {
            return "\(m):\(s)"
        } else {
            return "\(h):\(m):\(s)"
        }
    }
    
    func playAndPauseButtonTapped(){
        
        if player!.isPlaying {
            player?.pause()
            timer?.invalidate()
        } else {
            player?.play()
        }
    }
    
    func previousButtonTapped() {
        player?.stop()
        if controlCell! < surahList.count {
            controlCell = controlCell! - 1
        }
        tableView.reloadData()
        configure()
        
    }
    
    func NextButtonTapped() {
        player?.stop()
        if controlCell! < surahList.count {
            controlCell = controlCell! + 1
        }
        tableView.reloadData()
        configure()
    }
    
    func didChangevolume(value: Float) {
        print("Volune \(value)")
        self.volume = value
        player?.volume = self.volume
    }
    
    func didchangeTime(value: Float) {
        print("Time  \(value)")
        player?.currentTime = TimeInterval(value)
        startPlayer()
    }
    
    func speedSelectButtonTapped(_ sender: Int) {
        switch sender {
        case 0:
            player?.rate = 1.0
        case 1:
            player?.rate = 1.25
        case 2:
            player?.rate = 1.5
        case 3:
            player?.rate = 1.75
        case -1:
            player?.rate = 0.75
        case -2:
            player?.rate = 0.5
        case -3:
            player?.rate = 0.25
        default:
            player?.rate = 1.0
        }
//        playAndPauseButtonTapped()
//        player?.play()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surahList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if controlCell != nil && indexPath.row == controlCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AudioControlCell") as! AudioControlCell
            cell.playPause = self.playAndPauseButtonTapped
            cell.previousTrack = previousButtonTapped
            cell.nextTrack = NextButtonTapped
            cell.volume = didChangevolume
            cell.track = didchangeTime
            cell.playerSpeed = speedSelectButtonTapped
            cell.titleLabel.text = surahList[controlCell!].SurahTitle
            self.audioSlider =  cell.trackSlider
            self.currentTimeLabel = cell.currentTimeLabel
            self.totalTimeLabel = cell.totalDurationLabel
            
            if audioSlider != nil {
                configure()
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell") as! TitleCell
        cell.titleLabel.text = surahList[indexPath.row].SurahTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controlCell = indexPath.row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if controlCell != nil && indexPath.row == controlCell {
            return 162
        }
        return 50
    }
    
    
}


struct Surah {
    let SurahTitle: String
    let trackName: String
}
