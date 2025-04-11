//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Pablo Porzio (Modak) on 11/04/2025.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {

    
    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Player 1", score: 0, color: .red),
            Player(name: "Player 2", score: 5, color: .blue),
        ])
        scoreboard.resetScores(to: newValue)
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }
}
