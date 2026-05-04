//
//  StatCount.swift
//  finalproject2
//
//  Created by Parker Engelson on 4/21/26.
//

import SwiftUI
import Combine

// changed class to struct and added Codable so stats can be saved to UserDefaults
struct BasketballStats: Codable {
    var playerName: String
    var shots: Int
    var points: Int
    var rebounds: Int
    var assists: Int
    var steals: Int
    var blocks: Int
    var fouls: Int
    var fieldGoalPercentage: Double
   
    // Initializer
    init(playerName: String, shots: Int, points: Int, rebounds: Int, assists: Int, steals: Int, blocks: Int, fouls: Int, fieldGoalPercentage: Double) {
        self.playerName = playerName
        self.shots = shots
        self.points = points
        self.rebounds = rebounds
        self.assists = assists
        self.steals = steals
        self.blocks = blocks
        self.fouls = fouls
        self.fieldGoalPercentage = fieldGoalPercentage
    }
}

// made Player an ObservableObject with Identifiable (This object has a unique ID) + Codable (save player + reload after app refresh) so it can be persisted and observed
class Player: ObservableObject, Identifiable, Codable {
    let id: UUID
    @Published var stats: BasketballStats

    init(stats: BasketballStats) {
        self.id = UUID()
        self.stats = stats
    }
    
    // We manually implement Codable because @Published properties don’t automatically work with it
    //
    // CodingKeys tells Swift which properties we want to save/load
    // in my case, we only care about "id" and "stats"
    enum CodingKeys: String, CodingKey { case id, stats }
    // This initializer is used when we are LOADING (decoding) a Player from saved data
    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        stats = try c.decode(BasketballStats.self, forKey: .stats)
    }
    // This function is used when we are SAVING (encoding) a Player to data
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        // Encode each property into the container
        try c.encode(id, forKey: .id)
        try c.encode(stats, forKey: .stats)
    }
}

