//
//  TimerViewModel.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import Foundation
import Combine

//[]({})タイマー構造体の設定
class TimerViewModel {
    public var timer = Timer.publish(every: 1, on: .current, in: .common)
    private var cancellableTimer: Cancellable?
    
    public func start() {
        cancellableTimer = timer.connect()
    }
    
    public func stop() {
        guard let cTimer = cancellableTimer else { return }
        
        cTimer.cancel()
        timer = Timer.publish(every: 1, on: .current, in: .common)

    }
}
