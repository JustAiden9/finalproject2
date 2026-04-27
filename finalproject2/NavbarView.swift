//
//  NavbarView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct NavbarView: View {
    var onAddTapped: () -> Void
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 28) {
                ToolbarItem(icon: "chart.bar.fill", title: "Stats")
                ToolbarItem(icon: "arrow.down.doc.fill", title: "Export")
                ToolbarItem(icon: "rectangle.grid.2x2.fill", title: "Menu")
                ToolbarItem(icon: "gear", title: "Settings")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(Color.black)
            .clipShape(Capsule())
            
            Button { onAddTapped() } label: {
                VStack(spacing: 4) {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                }
                .foregroundColor(.black)
                .frame(width: 60, height: 60)
                .background(Color.orange)
                .clipShape(Circle())
            }
        }
        .padding()
    }
}

// Reusable toolbar item
struct ToolbarItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button {
            // Action here
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.caption2)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    ZStack {
        NavbarView(onAddTapped: {})
    }
}
