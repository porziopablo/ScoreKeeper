//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 04/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            SettingsView(
                startingPoints: $startingPoints,
                doesHighestScoreWin: $scoreboard.doesHighestScoreWin,
                roundsAmount: $scoreboard.roundsAmount
            )
            .padding(.bottom)
            .disabled(scoreboard.state != .setup || editMode.isEditing)
            HStack {
                Button("Add Player", systemImage: "plus") {
                    scoreboard.players.append(Player(name: "", score: 0, color: randomColor()))
                }
                .opacity(scoreboard.state == .setup ? 1 : 0)
                Spacer()
                EditButton()
                .opacity(scoreboard.state == .setup ? 1 : 0)
            }
            HStack {
                Spacer()
                Text("Round \(scoreboard.currentRound) of \(scoreboard.roundsAmount)")
                    .font(.title3)
                    .bold()
                    .opacity(scoreboard.state == .setup ? 0 : 1)
                Spacer()
            }
            List {
                Section {
                    HStack {
                        Text("Player")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Score")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(scoreboard.state == .setup ? 0 : 1)
                    }
                    .font(.headline)
                }
                ForEach($scoreboard.players) { $player in
                    HStack {
                        HStack {
                            if scoreboard.winners.contains(player) {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                            }
                            TextField("Name", text: $player.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .disabled(scoreboard.state != .setup)
                        }
                        HStack {
                            Text("\(player.score)")
                                .opacity(scoreboard.state == .setup ? 0 : 1)
                            Stepper("Score", value: $player.score, in: 0...20)
                                .labelsHidden()
                                .opacity(scoreboard.state != .playing ? 0 : 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        ColorPicker("Color", selection: $player.color)
                            .labelsHidden()
                            .disabled(scoreboard.state != .setup)
                    }
                }
                .onMove(perform: movePlayer)
                .onDelete(perform: deletePlayer)
            }
            .listStyle(.inset)
            HStack {
                Spacer()
                switch scoreboard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreboard.startGame(to: startingPoints)
                    }
                case .playing:
                    Button(
                        scoreboard.currentRound < scoreboard.roundsAmount ? "Next Round" : "End Game",
                        systemImage: scoreboard.currentRound < scoreboard.roundsAmount ? "forward.fill" : "stop.fill"
                    ) {
                        scoreboard.nextRound()
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockwise") {
                        scoreboard.startSetup()
                    }
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.blue)
            .opacity(editMode.isEditing ? 0 : 1)
        }
        .padding()
        .environment(\.editMode, $editMode)
    }
    
    private func randomColor() -> Color {
        Color(
           red: Double.random(in: 0...1),
           green: Double.random(in: 0...1),
           blue: Double.random(in: 0...1)
       )
    }
    
    private func deletePlayer(at offsets: IndexSet) {
        scoreboard.players.remove(atOffsets: offsets)
    }

    private func movePlayer(from source: IndexSet, to destination: Int) {
        scoreboard.players.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ContentView()
}
