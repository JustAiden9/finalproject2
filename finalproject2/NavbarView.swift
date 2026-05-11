//
//  NavbarView.swift
//  finalproject2
//
//  Created by Aiden Baker on 4/21/26.
//

import SwiftUI

struct NavbarView: View {
    var onAddTapped: () -> Void
    var onStatsTapped: () -> Void
    var onExportTapped: () -> Void
    var onSettingsTapped: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 28) {
                ToolbarItem(icon: "chart.bar.fill", title: "Help",    action: onStatsTapped)
                ToolbarItem(icon: "arrow.down.doc.fill", title: "Export",  action: onExportTapped)
                ToolbarItem(icon: "gear", title: "Settings", action: onSettingsTapped)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(Color.black)
            .clipShape(Capsule())

            Button { onAddTapped() } label: {
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.orange)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

struct ToolbarItem: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
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
    NavbarView(onAddTapped: {}, onStatsTapped: {}, onExportTapped: {}, onSettingsTapped: {})
}
