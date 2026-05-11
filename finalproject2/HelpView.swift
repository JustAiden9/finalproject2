//
//  HelpView.swift
//  finalproject2
//
//  Created by Aiden Baker on 5/8/26.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Welcome to Swish Stats")
                .font(.largeTitle)
                .bold()
            
            Text("Welcome to Swish Stats. Here is a quick guide:")
                .font(.headline)
            
            Text("- To add a new player to track you can tap the plus button in the bottom right corner.")
            
            Text("- To edit the stats like points, rebounds, and more click into the player and click the buttons to change the stats.")
            
            Text("- To export the stats you can go the exports tab and select the player you want to export.")
            
            Spacer() // Pushes the text to the top of the screen
        }
        .padding()
    }
}

#Preview {
    HelpView()
}
