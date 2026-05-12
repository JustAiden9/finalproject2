//
//  ExportView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct ExportView: View {
    var players: [Player]

    @State private var selectedPlayer: Player? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                // Player picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Select Player")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    if players.isEmpty {
                        Text("No players added yet.")
                            .foregroundColor(.gray)
                            .padding(.vertical, 8)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(players) { player in
                                    let isSelected = selectedPlayer?.id == player.id
                                    Button {
                                        selectedPlayer = player
                                    } label: {
                                        Text(player.stats.playerName)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                            .background(isSelected ? Color.orange : Color(.systemGray6))
                                            .foregroundColor(isSelected ? .white : .primary)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                            .padding(.horizontal, 1)
                        }
                    }
                }
                .padding(.horizontal, 24)

                // Stats preview
                if let player = selectedPlayer {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Stats Message")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)

                        Text(statsMessage(for: player))
                            .font(.system(.body, design: .monospaced))
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 24)

                    // Copy button
                    Button {
                        UIPasteboard.general.string = statsMessage(for: player)
                    } label: {
                        Label("Copy to Clipboard", systemImage: "doc.on.doc")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()
            }
            .padding(.top, 16)
            .navigationTitle("Export")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func statsMessage(for player: Player) -> String {
        let s = player.stats
        return """
        \(s.playerName)'s Game Stats
        Points:   \(s.points)
        Shots:    \(s.shots)
        Rebounds: \(s.rebounds)
        Assists:  \(s.assists)
        Steals:   \(s.steals)
        Blocks:   \(s.blocks)
        Fouls:    \(s.fouls)
        """
    }
}

#Preview {
    ExportView(players: [
        Player(stats: BasketballStats(
            playerName: "Parker",
            shots: 15, points: 22, rebounds: 8,
            assists: 5, steals: 2, blocks: 1,
            fouls: 3, fieldGoalPercentage: 0.53
        ))
    ])
}
