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
                    
                    Picker("Theme", selection: $isDarkMode) {
                        Text("Outdoor (Light)").tag(false)
                        Text("Indoor (Dark)").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}
