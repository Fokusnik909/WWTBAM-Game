//
//  AudioPlayerService.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 23.07.2025.
//

final class AudioPlayerService {
    static let shared = AudioPlayerService()
    private var players: [PlayerType: AudioPlayer] = [:]

    private init() {}

    func play(audioFile: AudioFile, type: PlayerType = .game, repeatable: Bool = false) {
        let player = AudioPlayer(fileName: audioFile.rawValue, repeatable: repeatable)
        players[type]?.stop()
        players[type] = player
        player.play()
    }

    func pause(type: PlayerType) {
        players[type]?.pause()
    }

    func resume(type: PlayerType) {
        players[type]?.resume()
    }

    func stop(type: PlayerType) {
        players[type]?.stop()
        players[type] = nil
    }
}

extension AudioPlayerService {
    enum PlayerType {
        case background, game
    }
    
    enum AudioFile: String {
        case correct, suspense, wait, winner, wrong
    }
}
