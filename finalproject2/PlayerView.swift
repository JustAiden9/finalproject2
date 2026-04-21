//
//  PlayerView.swift
//  finalproject2
//
//  Created by Parker Engelson on 4/21/26.
//

import SwiftUI

struct PlayerView: View {
    var player: Player
    var body: some View {
        VStack(spacing: 20) {
            // Name
            Text(player.stats.playerName)
                .font(.largeTitle)
                .fontWeight(.bold)
            // Shooting + Scoring
            VStack(alignment: .leading, spacing: 8) {
                Text("Shots: \(player.stats.shots)")
                Text("Points: \(player.stats.points)")
                Text("FG%: \(String(format: "%.1f", player.stats.fieldGoalPercentage * 100))%")
            }
            Divider()
            // Core Stats Grid
            HStack(spacing: 25) {
                StatBox(title: "REB", value: player.stats.rebounds)
                StatBox(title: "AST", value: player.stats.assists)
                StatBox(title: "STL", value: player.stats.steals)
                StatBox(title: "BLK", value: player.stats.blocks)
                StatBox(title: "FLS", value: player.stats.fouls)
            }
            Divider()
            // Discipline
        }
        .padding()
    }
}

struct StatBox: View {
    var title: String
    var value: Int
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    PlayerView(player: Player(stats: BasketballStats(
        playerName: "Parker",
        shots: 15,
        points: 22,
        rebounds: 8,
        assists: 5,
        steals: 2,
        blocks: 1,
        fouls: 3,
        fieldGoalPercentage: 0.53
    )))
}
