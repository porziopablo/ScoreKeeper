//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 11/04/2025.
//

import Foundation

struct Scoreboard {
    // config
    var doesHighestScoreWin = true
    var roundsAmount = 1
    var startingPoints = 0
    
    // game state
    var players: [Player] = [
        Player(name: "Juli", score: 0, color: .red),
        Player(name: "Mauro", score: 0, color: .blue),
        Player(name: "Pablo", score: 0, color: .green),
    ]
    var state = GameState.setup
    var currentRound = 1
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
    
    mutating func nextRound() {
        if currentRound == roundsAmount {
            state = .gameOver
        } else {
            currentRound += 1
        }
    }
    
    mutating func startGame() {
        state = .playing
        currentRound = 1
        resetScores(to: startingPoints)
    }
    
    mutating func startSetup() {
        state = .setup
    }
    
    mutating func addPlayer(newPlayer: Player) {
        players.append(newPlayer)
    }
    
    mutating func removePlayer(at index: Int) {
        players.remove(at: index)
    }
    
    mutating func movePlayer(from source: IndexSet, to destination: Int) {
        players.move(fromOffsets: source, toOffset: destination)
    }
}
