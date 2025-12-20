//
//  SettingsView.swift
//  Phase 1
//
//  Created by specktro on 13/12/25.
//

import SwiftUI

struct SettingsView: View {
    @UserDefault("theme", defaultValue: "light")
    var theme: String
    
    @UserDefault("notifications", defaultValue: true)
    var notificationsEnabled: Bool
    
    var body: some View {
        VStack {
            Text("Theme: \(theme)")
            
            Button("Toggle Theme") {
                theme = theme == "light" ? "dark" : "light"
            }
            
            Toggle("Notifications", isOn: $notificationsEnabled)
        }
    }
}

#Preview {
    SettingsView()
}
