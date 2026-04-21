//
//  StatCount.swift
//  finalproject2
//
//  Created by Parker Engelson on 4/21/26.
//

import SwiftUI

class BasketballStats {
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
