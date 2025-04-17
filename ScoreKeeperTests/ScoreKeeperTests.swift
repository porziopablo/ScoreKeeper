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
    
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .gameOver,
        )
        
        let winners = scoreboard.winners
        
        #expect(winners == [Player(name: "Player 1", score: 10, color: .red)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            doesHighestScoreWin: false,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .gameOver,
        )
        
        let winners = scoreboard.winners
        
        #expect(winners == [Player(name: "Player 2", score: 5, color: .blue)])
    }
    
    @Test("Multiple winners")
    func multipleWinners() {
        let scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 10, color: .blue),
                Player(name: "Player 3", score: 5, color: .green),
            ],
            state: .gameOver,
        )
        
        let winners = scoreboard.winners
        
        #expect(winners == [
            Player(name: "Player 1", score: 10, color: .red),
            Player(name: "Player 2", score: 10, color: .blue)
        ])
    }
    
    @Test("Change round")
    func changeRound() {
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .playing,
        )
        
        scoreboard.nextRound()
        
        #expect(scoreboard.currentRound == 2)
    }
    
    @Test("Game over")
    func gameOver() {
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .playing,
        )
        
        scoreboard.nextRound()
        scoreboard.nextRound()
        scoreboard.nextRound()
        
        #expect(scoreboard.state == .gameOver)
        #expect(scoreboard.currentRound == 3)
    }
    
    @Test("Start game")
    func startGame() {
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .setup,
            currentRound: 3,
        )
        
        scoreboard.startGame(to: 5)
        
        #expect(scoreboard.state == .playing)
        #expect(scoreboard.currentRound == 1)
        for player in scoreboard.players {
            #expect(player.score == 5)
        }
    }
    
    @Test("Start setup")
    func startSetup() {
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .gameOver,
            currentRound: 3,
        )
        
        scoreboard.startSetup()
        
        #expect(scoreboard.state == .setup)
    }
}
