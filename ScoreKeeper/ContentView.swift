//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 04/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(name:"Juli", score:0, color: .red),
        Player(name:"Mauro", score:0, color: .blue),
        Player(name:"Pablo", score:0, color: .green),
    ]
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            EditButton()
            
            if editMode == .active {
                List {
                    ForEach($players) { $player in
                        HStack {
                            TextField("Name", text: $player.name)
                            Spacer()
                            Stepper("", value: $player.score, in: 0...20)
                                .labelsHidden()
                        }
                    }
                    .onMove(perform: movePlayer)
                    .onDelete(perform: deletePlayer)
                }
            } else {
                Grid {
                    GridRow {
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Text("Score")
                    }
                    .font(.headline)
                    ForEach($players) { $player in
                        GridRow {
                            TextField("Name", text: $player.name)
                            Text("\(player.score)")
                            Stepper(
                                "Score",
                                value: $player.score,
                                in: 0...20
                            )
                            .labelsHidden()
                            ColorPicker("Color", selection: $player.color)
                                .labelsHidden()
                        }
                    }
                }
                .padding(.vertical)
                
                Button("Add Player", systemImage: "plus") {
                    players.append(Player(name: "", score: 0, color: randomColor()))
                }
                
                Spacer()
            }
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
        players.remove(atOffsets: offsets)
    }

    private func movePlayer(from source: IndexSet, to destination: Int) {
        players.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ContentView()
}
