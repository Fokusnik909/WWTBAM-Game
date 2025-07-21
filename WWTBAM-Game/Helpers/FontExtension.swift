//
//  FontExtension.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//

import SwiftUI

extension Font {
    enum SFCompact: String {
        case regular = "SFCompact-Regular"
        case semibold = "SFCompact-Semibold"
    }

    static func sfCompact(_ style: SFCompact, size: CGFloat = 24) -> Font {
        return .custom(style.rawValue, size: size)
    }
}

// Example
// .font(.sfCompact(.regular, size: 24))
