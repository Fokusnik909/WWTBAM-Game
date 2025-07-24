//
//  AudioPlayer.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 23.07.2025.
//

import AVFoundation

final class AudioPlayer {
    private var player: AVAudioPlayer?
    private let fileName: String
    private let repeatable: Bool

    init(fileName: String, repeatable: Bool = false) {
        self.fileName = fileName
        self.repeatable = repeatable
        prepare()
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func resume() {
        player?.play()
    }

    func stop() {
        player?.stop()
        player = nil
    }
}

// MARK: - Private Methods
private extension AudioPlayer {
    func prepare() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Файл \(fileName) не найден")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = repeatable ? -1 : 0
            player?.prepareToPlay()
        } catch {
            print("Ошибка при воспроизведении звука: \(error.localizedDescription)")
        }
    }
}
