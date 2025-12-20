//
//  DebouncedWrapper.swift
//  Phase 1
//
//  Created by specktro on 14/12/25.
//

import SwiftUI
import Combine

@propertyWrapper
struct Debounced: DynamicProperty {
    private let delay: TimeInterval
    
    @State private var immediateValue: String
    @State private var debouncedValue: String
    @State private var cancellable: AnyCancellable?
    
    init(wrappedValue: String, delay: TimeInterval = 0.5) {
        self.delay = delay
        _immediateValue = State(initialValue: wrappedValue)
        _debouncedValue = State(initialValue: wrappedValue)
    }
    
    var wrappedValue: String {
        get {
            debouncedValue
        }
        nonmutating set {
            immediateValue = newValue
            cancellable?.cancel()
            cancellable = Just(newValue)
                .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
                .sink(receiveValue: { value in
                    debouncedValue = value
                })
        }
    }
    
    var projectedValue: DebouncedProjection {
        DebouncedProjection(
            immediateBinding: Binding(
                get: { immediateValue },
                set: { wrappedValue = $0 }),
            debouncedValue: debouncedValue
        )
    }
}

struct DebouncedProjection {
    let immediateBinding: Binding<String>
    let debouncedValue: String
    
    var immediate: Binding<String> {
        immediateBinding
    }
    
    var immediateValue: String {
        immediateBinding.wrappedValue
    }
}

// MARK: - Demo App
struct DebouncedDemoView: View {
    @Debounced(delay: 0.8)
    var searchQuery: String = ""
    
    @State private var searchResults: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Debounced Search Demo")
                .font(.title)
            
            TextField("Search...", text: $searchQuery.immediate)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Immediate: \($searchQuery.immediateValue)")
                    .foregroundColor(.gray)
                
                Text("Debounced: \(searchQuery)")
                    .foregroundColor(.blue)
                    .bold()
            }
            .padding()
            
            Text("Debounced value updates 0.8s after you stop typing")
                .font(.caption)
                .foregroundColor(.secondary)
            
            if !searchResults.isEmpty {
                List(searchResults, id: \.self) { result in
                    Text(result)
                }
            }
        }
        .onChange(of: searchQuery) { _, newValue in
            performSearch(newValue)
        }
    }
    
    func performSearch(_ query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        print("🔍 Searching for: \(query)")
        
        // Simulate API call
        searchResults = [
            "\(query) - Result 1",
            "\(query) - Result 2",
            "\(query) - Result 3"
        ]
    }
}

#Preview {
    DebouncedDemoView()
}
