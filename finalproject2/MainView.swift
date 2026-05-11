//
//  MainView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct MainView: View {
    @State private var players: [Player] = MainView.loadPlayers()
    @State private var showingAddPlayer = false
    @State private var showingExport    = false
    @State private var showingSettings  = false
    @State private var showingHelp  = false

    
    var body: some View {
        NavigationStack {
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
                                // pass onSave so stat changes in PlayerView write back here and get persisted
                                ForEach(players.indices, id: \.self) { i in
                                    NavigationLink(destination: PlayerView(player: players[i], onSave: { updated in
                                        players[i] = updated
                                        savePlayers()
                                    })) {
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
                NavbarView(
                     onAddTapped:      { showingAddPlayer = true },
                     onStatsTapped:    { showingHelp = true },
                     onExportTapped:   { showingExport = true },
                     onSettingsTapped: { showingSettings = true }
                 )
             }
            
            // when the user saves, the new Player is handed back here and then to the
            // players array, which triggers the list to re-render with the new entry.
             .sheet(isPresented: $showingAddPlayer) {
                 AddPlayerView { newPlayer in
                     players.append(newPlayer)
                     savePlayers() // persist immediately when a new player is added
                 }
             }
             .sheet(isPresented: $showingExport) {
                 ExportView()
             }
             .sheet(isPresented: $showingSettings) {
                 SettingsView()
             }
             .sheet(isPresented: $showingHelp) {
                 HelpView()
             }
            // Also save when the player count changes
             .onChange(of: players.count) { _, _ in
                 savePlayers()
             }
         }
     }
    
    // encode the players array to JSON and write to UserDefaults
    func savePlayers() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: "players")
        }
    }

    // read and decode the players array from UserDefaults at launch
    static func loadPlayers() -> [Player] {
        guard let data = UserDefaults.standard.data(forKey: "players"),
              let decoded = try? JSONDecoder().decode([Player].self, from: data)
        else { return [] }
        return decoded
    }
}

#Preview {
    MainView()
}
