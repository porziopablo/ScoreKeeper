//
//  Player.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 04/12/2024.
//

import Foundation
import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    
    var name: String
    var score: Int
    var color: Color
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.score == rhs.score && lhs.color == rhs.color
    }
}
