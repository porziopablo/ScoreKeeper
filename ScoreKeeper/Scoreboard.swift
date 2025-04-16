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
    var doesHighestScoreWin = true
    
    var winners: [Player] {
        guard state == .gameOver else { return [] }
        
        var winningScore = 0
        
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        
        return players.filter { player in player.score == winningScore }
    }
    
    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
