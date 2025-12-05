//
//  Day1_Quiz.swift
//  Phase 1
//
//  Created by specktro on 29/11/25.
//

import SwiftUI

// Quiz 1.1 - SwiftUI Fundamentals
// Name: specktro

// Question 1: Why are SwiftUI views structs instead of classes?
// Give at least 2 technical reasons.
// Answer:
// - Value semantics: Structs are copied, not referenced. When SwiftUI creates a new view tree, it copies lightweight structs instead of managing object references
// - No reference counting overhead: Classes need ARC (retain/release). Structs avoid this entirely → better performance
// - Thread-safe by default: No shared mutable state means no race conditions
// - Simpler memory model: Stack allocation for small structs, predictable lifetime
//

// Question 2: What does 'some View' mean? Why not just 'View'?
// Explain and show a code example.
// Answer: This is a opaque type in order to hide view composition complexity, i.e. when you are using a view modifier the view type is not just View, sometimes could be a tuple compound from two or more view types, with 'some View' you can just receive a view without any concern about the types
//

// Question 3: Run this code. Why do they look different?
struct TestView: View {
    var body: some View {
        VStack {
            // Example A
            Text("A")
                .padding()
                .background(Color.blue)
            
            // Example B
            Text("B")
                .background(Color.red)
                .padding()
        }
    }
}
// Answer: Why are they different?
// working with a view modifiers we have to worry about the order, in the first example the view first allocate some padding space and later put a color in all that space in the second example the view first put a red color as background and later add some space with the paddin around that background

#Preview {
    TestView()
}
