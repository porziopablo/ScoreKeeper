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
