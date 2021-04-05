//
//  TimerVC.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 1/16/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 30
        return stack
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = CycleStatus.restart.rawValue
        label.textAlignment = .center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt", size: 40)
        label.textAlignment = .center
        label.text = "0:00"
        return label
    }()
    
    let startPauseButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("START", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.systemIndigo
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let resetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Reset", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        return btn
    }()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Close", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        return btn
    }()
    
    let tomatoesView: TomatoesView = {
        let view = TomatoesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // Array of intervals that make up one session specifying if it's a break or pomodoro
    let intervals: [IntervalType] = [.pomodoro,.breakInterval,.pomodoro,.breakInterval,.pomodoro,.breakInterval,.pomodoro]
    
    // Keeps track of where we are in the intervals
    var currentInterval = 0
    
    // Setting the duration of each type of interval in seconds, for testing purposes they are short.
    let pomodoroDuration = 10 // Real: 25 * 60
    let breakDuration = 5 //Real:  5 * 60
    
    var timeRemaining = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //TODO: Set button actions for startPauseButton, resetButton and closeButton
        
        resetAll()
    }
    
    // MARK: Button Actions
    
    @objc func startPauseButtonPressed(_ sender: UIButton) {
        if timer.isValid {
         // Timer running
         // TODO: Change the button’s title to “Continue”
         // TODO: Enable the reset button
         // TODO: Pause the timer, call the method pauseTimer
            
           
        } else {
         // Timer stopped or hasn't started
         // TODO: Change the button’s title to “Pause”
         // TODO: Disable the Reset button
            
            if currentInterval == 0 && timeRemaining == pomodoroDuration {
                // We are at the start of a cycle
                // TODO: begin the cycle of intervals
                
            } else {
                // We are in the middle of a cycle
                // TODO: Resume the timer.
                
            }
        }
    }
    
    @objc func resetButtonPressed(_ sender: UIButton) {
        if timer.isValid {
            timer.invalidate()
        }
        //TODO: call the reset method
    }

    // MARK: Create UI
    
    func setup(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(contentStack)
        contentStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentStack.addArrangedSubview(messageLabel)
        contentStack.addArrangedSubview(timeLabel)
        contentStack.addArrangedSubview(tomatoesView)
        tomatoesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        contentStack.addArrangedSubview(startPauseButton)
        startPauseButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        contentStack.addArrangedSubview(resetButton)
        resetButton.heightAnchor.constraint(equalTo: startPauseButton.heightAnchor).isActive = true
        contentStack.addArrangedSubview(closeButton)
        closeButton.heightAnchor.constraint(equalTo: startPauseButton.heightAnchor).isActive = true
    }
    
    // MARK: Time Manipulation
    
    func updateTime() {
        let (minutes, seconds) = minutesAndSeconds(from: timeRemaining)
        let min = formatNumber(minutes)
        let sec = formatNumber(seconds)
        timeLabel.text = "\(min) : \(sec)"
    }
    
    func startTimer() {
        //TODO: create the timer, the action called should be runTimer()
        
    }
    
    @objc func runTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTime()
        } else {
            timer.invalidate()
            startNextInterval()
        }
    }

    func pauseTimer() {
        timer.invalidate()
        messageLabel.text = CycleStatus.pause.rawValue
    }

    func resetAll() {
        currentInterval = 0
        tomatoesView.updateTomatoes(to: 1)
        messageLabel.text = CycleStatus.restart.rawValue
        startPauseButton.setTitle("Start", for: .normal)
        resetButton.isEnabled = false
        timeRemaining = pomodoroDuration
        updateTime()
    }

    func startNextInterval() {
        if currentInterval < intervals.count {
            // If not done with all intervals, do the next one.
            if intervals[currentInterval] == .pomodoro {
                // Pomodoro interval
                timeRemaining = pomodoroDuration
                messageLabel.text = CycleStatus.active.rawValue
                let tomatoes = (currentInterval + 2) / 2
                tomatoesView.updateTomatoes(to: tomatoes)
            } else {
                // Rest break interval
                timeRemaining = breakDuration
                messageLabel.text = CycleStatus.breakStatus.rawValue
            }
            updateTime()
            startTimer()
            currentInterval += 1
        } else {
            // If all intervals are complete, reset all.
            // TODO: Post Notification
            resetAll()
        }
    }

    // MARK: Formatters
    
    // Input: number of seconds, returns it as (minutes, seconds).
    func minutesAndSeconds(from seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }

    // Input: number, returns a string of 2 digits with leading zero if needed
    func formatNumber(_ number: Int) -> String {
        return String(format: "%02d", number)
    }
}
