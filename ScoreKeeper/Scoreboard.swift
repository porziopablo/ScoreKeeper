//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 11/04/2025.
//

import Foundation

struct Scoreboard {
    var players: [Player] = [
        Player(name:"Juli", score:0, color: .red),
        Player(name:"Mauro", score:0, color: .blue),
        Player(name:"Pablo", score:0, color: .green),
    ]
    
    var state = GameState.setup
    
    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
