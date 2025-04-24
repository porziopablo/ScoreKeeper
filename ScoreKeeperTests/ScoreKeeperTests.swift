//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Pablo Porzio (Modak) on 11/04/2025.
//

import Foundation
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
            startingPoints: 5,
            players: [
                Player(name: "Player 1", score: 10, color: .red),
                Player(name: "Player 2", score: 5, color: .blue),
            ],
            state: .setup,
            currentRound: 3,
        )
        
        scoreboard.startGame()
        
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
    
    @Test("Add player")
    func addPlayer() {
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: []
        )
        let newPlayer = Player(name: "Player 1", score: 0, color: .red)
        scoreboard.addPlayer(newPlayer: newPlayer)
        
        if scoreboard.players.count != 1 {
            #expect(Bool(false), "Expected players count to be 1")
            return
        }
        #expect(scoreboard.players[0] == newPlayer)
    }
    
    @Test("Delete player")
    func deletePlayer() {
        let player1 = Player(name: "Player 1", score: 0, color: .red)
        let player2 = Player(name: "Player 2", score: 0, color: .blue)
        
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [player1, player2]
        )
        
        scoreboard.removePlayer(at: 0)
        
        #expect(scoreboard.players.count == 1)
        #expect(scoreboard.players[0] == player2)
        #expect(scoreboard.players.contains(player1) == false)
    }
    
    @Test("Move player")
    func movePlayer() {
        let player1 = Player(name: "Player 1", score: 0, color: .red)
        let player2 = Player(name: "Player 2", score: 0, color: .blue)
        
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            players: [player1, player2]
        )
        
        scoreboard.movePlayer(from: IndexSet(integer: 0), to: 2)
        
        #expect(scoreboard.players[0] == player2)
        #expect(scoreboard.players[1] == player1)
        #expect(scoreboard.players.count == 2)
    }
    
    @Test("Check for winner when highest score wins")
    func checkForWinnerHighestScoreWins() {
        let player1 = Player(name: "Player 1", score: 0, color: .red)
        let player2 = Player(name: "Player 2", score: 10, color: .blue)
        
        var scoreboard = Scoreboard(
            doesHighestScoreWin: true,
            roundsAmount: 3,
            winningPoints: 10,
            players: [player1, player2],
            state: .playing,
            currentRound: 2,
        )
        
        scoreboard.checkForWinner()
        
        #expect(scoreboard.state == .gameOver)
        #expect(scoreboard.winners == [player2])
    }
    
    @Test("Check for winner when lowest score wins")
    func checkForWinnerLowestScoreWins() {
        let player1 = Player(name: "Player 1", score: 10, color: .red)
        let player2 = Player(name: "Player 2", score: 0, color: .blue)
        
        var scoreboard = Scoreboard(
            doesHighestScoreWin: false,
            roundsAmount: 3,
            winningPoints: 0,
            players: [player1, player2],
            state: .playing,
            currentRound: 2,
        )
        
        scoreboard.checkForWinner()
        
        #expect(scoreboard.state == .gameOver)
        #expect(scoreboard.winners == [player2])
    }
}
