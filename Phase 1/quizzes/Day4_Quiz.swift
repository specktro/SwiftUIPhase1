//
//  Day4_Quiz.swift
//  Phase 1
//
//  Created by specktro on 13/12/25.
//

// Quiz 4.1 - Property Wrappers
// Name: @specktro

import Foundation

// Question 1: What are the required components of a property wrapper?
// Answer: declare as @propertyWrapper and add at least the wrappedValue property variable
//

// Question 2: What does 'nonmutating set' do and why is it needed?
// Answer: it allows us to mutate a property even if it is inside a struct
//

// Question 3: Implement a @Lowercase property wrapper
// It should automatically convert strings to lowercase
@propertyWrapper
struct Lowercase {
    // Your implementation
    private var value: String = ""
    
    var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue.lowercased()
        }
    }
}

// Test:
struct User {
    @Lowercase var email: String
}

var user = User()
//user.email = "JOHN@EXAMPLE.COM" // uncommented this and test it in a playground
// Should print: john@example.com // uncommented this and test it in a playground
//print(user.email)

// Question 4: What's the difference between wrappedValue and projectedValue?
// When would you use each?
// Answer: wrappedValue is the property itself, meanwhile the projectedValue could be different and you have to access it with the prefix $, so, for example the projectedValue could be used as a Binding property to update some State inside a view the the @propertyWrapper changes its value
//

// Question 5: Implement a @Clamped property wrapper
// It should keep values within a specified range
@propertyWrapper
struct Clamped<T: Comparable> {
    // Your implementation
    private var value: T
        private let range: ClosedRange<T>
        
        var wrappedValue: T {
            get { value }
            set { value = min(max(range.lowerBound, newValue), range.upperBound) }
        }
        
        init(wrappedValue: T, _ range: ClosedRange<T>) {
            self.range = range
            self.value = min(max(range.lowerBound, wrappedValue), range.upperBound)
        }
}

// Test:
struct Player {
    @Clamped(0...100) var health: Int = 100
}

var player = Player()
//player.health = 150 // uncommented this and test it in a playground
//print(player.health) // Should print: 100 // uncommented this and test it in a playground
//player.health = -20 // uncommented this and test it in a playground
//print(player.health) // Should print: 0 // uncommented this and test it in a playground
