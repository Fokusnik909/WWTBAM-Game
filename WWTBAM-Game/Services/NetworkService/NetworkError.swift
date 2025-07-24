//
//  NetworkError.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 24.07.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Int)
    case decodingError(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingError(let error):
            return "Failed to decode JSON: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error occurred: \(error.localizedDescription)"
        }
    }
}
