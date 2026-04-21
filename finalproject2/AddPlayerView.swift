//
//  AddPlayerView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.dismiss) var dismiss // lets this view close itself when done
    var onSave: (Player) -> Void // callback that sends the new player back to MainView

    @State private var playerName: String = "" // tracks what the user types in the name field

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.12))
                        .frame(width: 80, height: 80)
                    Image(systemName: "person.fill.badge.plus")
                        .font(.system(size: 34))
                        .foregroundColor(.orange)
                }
                .padding(.top, 12)

                // Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Player Name")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    TextField("e.g. Parker", text: $playerName)
                        .font(.body)
                        .padding(14)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, 24)
                
                // Save button
                Button {
                    // Build a new Player using the entered name and zeroed-out stats.
                    // All counting stats start at 0 because no game has been tracked yet.
                    let newPlayer = Player(stats: BasketballStats(
                        playerName: playerName,
                        shots: 0,
                        points: 0,
                        rebounds: 0,
                        assists: 0,
                        steals: 0,
                        blocks: 0,
                        fouls: 0,
                        fieldGoalPercentage: 0.0
                    ))

                    // Pass the new player back to the parent view via the onSave closure,
                    // then dismiss this sheet so the user returns to the player list.
                    onSave(newPlayer)
                    dismiss()
                } label: {
                    Text("Add Player")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .animation(.easeInOut(duration: 0.2), value: playerName)
                }
                .padding(.horizontal, 24)
                Spacer()
            }
            .navigationTitle("New Player")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel") { dismiss() })
        }
    }
}

#Preview {
    AddPlayerView { _ in }
}
