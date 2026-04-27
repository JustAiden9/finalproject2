//
//  SettingsView.swift
//  finalproject2
//
//  Created by Alex Artamonov on 4/22/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    
                    Toggle(isOn: $isDarkMode){
                        HStack{
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            Text(isDarkMode ? "Indoor (Dark Mode)" : "Outdoor (Light Mode)")
                        }
                    }
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}
