//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Pablo Porzio (Modak) on 11/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var startingPoints: Int
    @Binding var doesHighestScoreWin: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            Divider()
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest score wins").tag(true)
                Text("Lowest score wins").tag(false)
            }
            Picker("Starting Points", selection: $startingPoints) {
                Text("0 starting points").tag(0)
                Text("10 starting points").tag(10)
                Text("20 starting points").tag(20)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
    }
}

#Preview {
    @Previewable @State var startingPoints = 10
    @Previewable @State var doesHighestScoreWin = true
    SettingsView(startingPoints: $startingPoints, doesHighestScoreWin: $doesHighestScoreWin)
}
