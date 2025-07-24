//
//  NetworkService.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 24.07.2025.
//

import Foundation

final class NetworkService {
    func fetchQuestions() async throws -> [Response.Question] {
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = [
            URLQueryItem(name: Constants.Query.amount, value: "50"),
            URLQueryItem(name: Constants.Query.type, value: RequestQuery.QuestionType.multiple.rawValue),
        ]

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed((response as? HTTPURLResponse)?.statusCode ?? -1)
            }

            do {
                let decoded = try JSONDecoder().decode(Response.self, from: data)
                return decoded.results
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

// MARK: - Query
extension NetworkService {
    struct RequestQuery {
        let amount: Int
        let difficulty: Difficulty
        let type: QuestionType = .multiple
        
        enum Difficulty: String {
            case easy, medium, hard
        }
        
        enum QuestionType: String {
            case multiple, boolean
        }
    }
}

// MARK: - Constants
private extension NetworkService {
    enum Constants {
        static let baseURL = "https://opentdb.com/api.php"
        
        enum Query {
            static let amount = "amount"
            static let difficulty = "difficulty"
            static let type = "type"
        }
    }
}
