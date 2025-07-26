//
//  String+extension.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 26.07.2025.
//

import Foundation

 extension String {
    var htmlDecoded: String {
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        // Используем NSAttributedString для парсинга HTML-энкодинга
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
    }
}
