//
//  Day2_Quiz.swift
//  Phase 1
//
//  Created by specktro on 29/11/25.
//

import SwiftUI

// Question 1: What's the difference between @State and @Binding?
// When would you use each?
// Answer: @State defines a source of truth usually a value type in the same view, @Binding represents an external dependency coudl change any time but there is not any concern of the view where that depedency comes from, it just receives the value and updates it if necessary

// Question 2: What does the $ (dollar sign) do?
// Show a code example: The dollar sign creates a two-way connection between a @State vatiable and the place where it was sent, so, the child view can update the original value from parent view.

struct ParentView: View {
    @State private var name = ""
    
    var body: some View {
        ChildView(name: $name)
    }
}

struct ChildView: View {
    @Binding var name: String
    
    var body: some View {
        TextField("Name", text: $name)
    }
}

// Question 3: Fix this broken code and explain what was wrong
//struct BrokenView: View {
//    var count = 0  // ❌ What's wrong here?
//    
//    var body: some View {
//        VStack {
//            Text("Count: \(count)")
//            Button("Increment") {
//                count += 1  // This won't work!
//            }
//        }
//    }
//}

// Fixed version:
struct BrokenView: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("Increment") {
                count += 1
            }
        }
    }
}

// Explanation of what was wrong:
// The counter value needed an @State property wrapper because it represents the source of truth for Text view representation of that value change

// Question 4: Why is @State always 'private'?
// Answer: Because it holds the state of a view and its own hierarchy, this prevents anything from altering the source of truth from the outside.

// Question 5: Implement this correctly
// Parent has a @State color
// Child has a ColorPicker that modifies parent's color
// Both show the current color

// Your implementation:
struct ColorPickerParent: View {
    @State private var color: Color = .orange
    
    var body: some View {
        VStack {
            Text("Selected Color")
                .font(.largeTitle)
                .foregroundStyle(color)
            ColorPickerChild(color: $color)
        }
    }
}

struct ColorPickerChild: View {
    @Binding var color: Color
    
    var body: some View {
        ColorPicker("Select a color", selection: $color)
    }
}

#Preview {
    ColorPickerParent()
}
