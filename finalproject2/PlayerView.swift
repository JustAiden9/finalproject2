//
//  PlayerView.swift
//  finalproject2
//
//  Created by Parker Engelson on 4/21/26.
//

import SwiftUI

struct PlayerView: View {
    @State private var points: Int
    @State private var shots: Int
    @State private var rebounds: Int
    @State private var assists: Int
    @State private var steals: Int
    @State private var blocks: Int
    @State private var fouls: Int
    
    // Track which stat we are currently editing with the wheel
    @State private var selectedStat: String = "Points"
    
    var player: Player
    // callback so MainView can receive the updated player and persist it
    var onSave: (Player) -> Void

    // this ensures that when the screen loads, the numbers you see on your screen match the actual data for that player.
    init(player: Player, onSave: @escaping (Player) -> Void) {
        self.player = player
        self.onSave = onSave // store the callback
        _points = State(initialValue: player.stats.points)
        _shots = State(initialValue: player.stats.shots)
        _rebounds = State(initialValue: player.stats.rebounds)
        _assists = State(initialValue: player.stats.assists)
        _steals = State(initialValue: player.stats.steals)
        _blocks = State(initialValue: player.stats.blocks)
        _fouls = State(initialValue: player.stats.fouls)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(player.stats.playerName)
                .font(.largeTitle)
                .fontWeight(.bold)

            // The Active Wheel Section
            // This changes dynamically based on what you tap below
            VStack {
                Picker(selectedStat, selection: binding(for: selectedStat)) {
                    ForEach(0..<101) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
            }
            .background(Color(.systemGray6))
            .cornerRadius(15)

            Divider()

            // Interactive Stat Grid
            // Tapping these updates the 'selectedStat' which switches the wheel
            VStack(spacing: 20) {
                HStack(spacing: 25) {
                    StatBox(title: "Points", value: points, isSelected: selectedStat == "Points")
                        .onTapGesture { selectedStat = "Points" }
                    StatBox(title: "Shots", value: shots, isSelected: selectedStat == "Shots")
                        .onTapGesture { selectedStat = "Shots" }
                }
                
                HStack(spacing: 25) {
                    StatBox(title: "Rebounds", value: rebounds, isSelected: selectedStat == "Rebounds")
                        .onTapGesture { selectedStat = "Rebounds" }
                    StatBox(title: "Assists", value: assists, isSelected: selectedStat == "Assists")
                        .onTapGesture { selectedStat = "Assists" }
                    StatBox(title: "Steals", value: steals, isSelected: selectedStat == "Steals")
                        .onTapGesture { selectedStat = "Steals" }
                }
                
                HStack(spacing: 25) {
                    StatBox(title: "Blocks", value: blocks, isSelected: selectedStat == "Blocks")
                        .onTapGesture { selectedStat = "Blocks" }
                    StatBox(title: "Fouls", value: fouls, isSelected: selectedStat == "Fouls")
                        .onTapGesture { selectedStat = "Fouls" }
                }
            }

            //save button: writes local state back to the player and fires the callback
            Button("Save Stats") {
                player.stats.points = points
                player.stats.shots = shots
                player.stats.rebounds = rebounds
                player.stats.assists = assists
                player.stats.steals = steals
                player.stats.blocks = blocks
                player.stats.fouls = fouls
                onSave(player)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    // this asks, Which stat is the user currently looking at, If you've selected "REB", it connects the wheel to the rebounds variable.
    private func binding(for stat: String) -> Binding<Int> {
        switch stat {
        case "Points": return $points
        case "Shots": return $shots
        case "Rebounds": return $rebounds
        case "Assists": return $assists
        case "Steals": return $steals
        case "Blocks": return $blocks
        case "Fouls": return $fouls
        default: return $points
        }
    }
}


// Instead of writing the code for a little square box seven different times, we just just condense it all down into one. we call each stat one by one in one function.
struct StatBox: View {
    var title: String
    var value: Int
    var isSelected: Bool // Visual feedback
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .blue : .primary)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .blue : .gray)
        }
        .frame(width: 60, height: 60)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(10)
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
    )), onSave: { _ in }) // MARK: - Dummy closure for preview
}
