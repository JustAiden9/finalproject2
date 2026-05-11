//
//  PlayerView.swift
//  finalproject2
//
//  Created by Parker Engelson on 4/21/26.
//

import SwiftUI

struct PlayerView: View {
    // all the vars for the stats
    @State private var points: Int
    @State private var shots: Int
    @State private var rebounds: Int
    @State private var assists: Int
    @State private var steals: Int
    @State private var blocks: Int
    @State private var fouls: Int

    // Undo stack, each entry is a snapshot of all stats before a tap
    @State private var undoStack: [(points: Int, shots: Int, rebounds: Int, assists: Int, steals: Int, blocks: Int, fouls: Int)] = []

    var player: Player
    var onSave: (Player) -> Void

    // use this to set up our @State with the existing stats from the (player) object.
    init(player: Player, onSave: @escaping (Player) -> Void) {
        self.player = player
        self.onSave = onSave
        // Use _ to access the State storage and set the starting value so the last used value after app closure.
        _points   = State(initialValue: player.stats.points)
        _shots    = State(initialValue: player.stats.shots)
        _rebounds = State(initialValue: player.stats.rebounds)
        _assists  = State(initialValue: player.stats.assists)
        _steals   = State(initialValue: player.stats.steals)
        _blocks   = State(initialValue: player.stats.blocks)
        _fouls    = State(initialValue: player.stats.fouls)
    }

    var body: some View {
        VStack(spacing: 24) {
            // Player name
            Text(player.stats.playerName)
                .font(.largeTitle)
                .fontWeight(.bold)

            // Stat grid
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    StatTapBox(title: "Points",   value: points)   { increment(&points) } // It runs when the box is tapped sends the data to our stats above to change the number.
                    StatTapBox(title: "Shots",    value: shots)    { increment(&shots) }
                }
                HStack(spacing: 16) {
                    StatTapBox(title: "Rebounds", value: rebounds) { increment(&rebounds) }
                    StatTapBox(title: "Assists",  value: assists)  { increment(&assists) }
                }
                HStack(spacing: 16) {
                    StatTapBox(title: "Steals",   value: steals)   { increment(&steals) }
                    StatTapBox(title: "Blocks",   value: blocks)   { increment(&blocks) }
                }
                HStack(spacing: 16) {
                    StatTapBox(title: "Fouls",    value: fouls)    { increment(&fouls) }
                }
            }
            .padding(.horizontal)

            // Undo button, only visible when there's something to undo if not it will be hidden
            if !undoStack.isEmpty {
                Button {
                    undo()
                } label: {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
            }

            Spacer()

            // Save
            Button("Save Stats") {
                // Update the player object with our local @State values
                player.stats.points   = points
                player.stats.shots    = shots
                player.stats.rebounds = rebounds
                player.stats.assists  = assists
                player.stats.steals   = steals
                player.stats.blocks   = blocks
                player.stats.fouls    = fouls
                // Call the function passed in from the main view
                onSave(player)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
        }
        .padding(.top)
    }

    // Save a snapshot, then increment
    // inout allows this function to modify the variable directly.
    private func increment(_ stat: inout Int) {
        undoStack.append((points, shots, rebounds, assists, steals, blocks, fouls))
        stat += 1
    }

    // Pop the last snapshot and restore all values
    private func undo() {
        // 'guard let' safely checks if the stack has a last item.
        // If it's empty, it returns and does nothing.
        guard let last = undoStack.popLast() else { return }
        // Restore all values from that "snapshot"
        points   = last.points
        shots    = last.shots
        rebounds = last.rebounds
        assists  = last.assists
        steals   = last.steals
        blocks   = last.blocks
        fouls    = last.fouls
    }
}

// Tap-to-increment stat card
struct StatTapBox: View {
    var title: String
    var value: Int
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text("\(value)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.primary)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain) // Prevents the button from looking like a blue link
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
    )), onSave: { _ in })
}
