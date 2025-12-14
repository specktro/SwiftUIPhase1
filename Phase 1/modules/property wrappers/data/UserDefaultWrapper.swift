//
//  UserDefault.swift
//  Phase 1
//
//  Created by specktro on 13/12/25.
//

import SwiftUI
import Combine

@propertyWrapper
struct UserDefault<T>: DynamicProperty {
    private let key: String
    private let defaultValue: T
    @State private var value: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self.value = UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        
    }
    
    var wrappedValue: T {
        get {
            value
        }
        nonmutating set {
            value = newValue
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    var projectedValue: Binding<T> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}

// MARK: - Demo App
struct UserDefaultDemoView: View {
    @UserDefault("username", defaultValue: "")
    var username: String
    
    @UserDefault("isDarkMode", defaultValue: false)
    var isDarkMode: Bool
    
    @UserDefault("fontSize", defaultValue: 16)
    var fontSize: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("UserDefaults Demo")
                .font(.title)
            
            // Username field
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("Saved username: \(username)")
            
            // Dark mode toggle
            Toggle("Dark Mode", isOn: $isDarkMode)
                .padding()
            
            // Font size stepper
            Stepper("Font Size: \(fontSize)", value: $fontSize, in: 12...24)
                .padding()
            
            // Show that values persist
            Text("Values are automatically saved!")
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Clear button
            Button("Clear All") {
                username = ""
                isDarkMode = false
                fontSize = 16
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    UserDefaultDemoView()
}
