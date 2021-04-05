//
//  ModelStructs.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 4/4/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

/// There are two types of time intervals:
///   1. Pomodoro: working on a task for 25 minutes without interruptions
///   2. Break: 5 minutes
enum IntervalType {
    case pomodoro
    case breakInterval
}

/// Timer Status
enum CycleStatus: String{
    case breakStatus = "Taking a break"
    case active = "Pomodoro in session, do not disturb"
    case restart = "Ready to work"
    case pause = "Timer paused"
}
