//
//  PlayerRowView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct PlayerRowView: View {
    var player: Player

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.15))
                    .frame(width: 46, height: 46)
                Text(String(player.stats.playerName.prefix(1)).uppercased()) // allows us to show the first letter of the users name in the pfp (we want to add real pfp soon)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(player.stats.playerName)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(player.stats.points) pts · \(player.stats.rebounds) reb · \(player.stats.assists) ast")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(14)
    }
}

#Preview {
    PlayerRowView(player: Player(stats: BasketballStats(
        playerName: "Parker",
        shots: 10,
        points: 18,
        rebounds: 7,
        assists: 5,
        steals: 1,
        blocks: 0,
        fouls: 2,
        fieldGoalPercentage: 0.60
    )))
}
