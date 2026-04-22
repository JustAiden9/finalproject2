//
//  MainView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct MainView: View {
    @State private var players: [Player] = []
    @State private var showingAddPlayer = false
    @State private var showingSettings = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack() {
                // Header
                HStack {
                    Text("Game Stats")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                // Player list
                if players.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "person.3")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No players yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Tap + to add a player")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(players.indices, id: \.self) { i in
                                NavigationLink(destination: PlayerView(player: players[i])) {
                                    PlayerRowView(player: players[i])
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100) // clearance for navbar
                    }
                }
            }

            // Navbar pinned to bottom
            NavbarView(onAddTapped: { showingAddPlayer = true })
        }
        
        // when the user saves, the new Player is handed back here and then to the
        // players array, which triggers the list to re-render with the new entry.
        .sheet(isPresented: $showingAddPlayer) {
            AddPlayerView { newPlayer in
                players.append(newPlayer)
            }
        }
    }
}

#Preview {
    MainView()
}
