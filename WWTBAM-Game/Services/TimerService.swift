//
//  TimerService.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 25/07/2025.
//

import Foundation
import Combine

final class TimerService: ObservableObject {
    @Published private(set) var remainingTime: Int = 30
    @Published private(set) var isRunning: Bool = false

    private var timer: AnyCancellable?
    private var totalTime: Int = 30

    func start(duration: Int = 30) {
        stop()
        totalTime = duration
        remainingTime = duration
        isRunning = true

        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            stop()
        }
    }

    func stop() {
        timer?.cancel()
        timer = nil
        isRunning = false
    }
}
