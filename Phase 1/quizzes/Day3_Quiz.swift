//
//  Day3_Quiz.swift
//  Phase 1
//
//  Created by specktro on 07/12/25.
//

// Quiz 3.1 - Result Builders
// Name: @specktro

import Foundation

// Question 1: What does @resultBuilder do?
// Explain in your own words:
// Answer: It helps us create data structures in a simple and declarative way

// Question 2: Implement buildBlock for 1, 2, and 3 components
// This should work with strings and combine them with commas

@resultBuilder
struct CommaBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: ", ")
    }
}

// This should work:
@CommaBuilder
func makeList() -> String {
    "Apple"
    "Banana"
    "Cherry"
}
// Expected output: "Apple, Banana, Cherry"

// Test your implementation:
// print(makeList())


// Question 3: Why does this fail? Fix it.
@resultBuilder
struct BrokenBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined()
    }
}

//@BrokenBuilder
//func conditional() -> String {
//    "Hello"
//    if true {
//        "World"  // ❌ Error! Why?
//    }
//}

// Explanation of what's wrong: It was necessary to implement the function that allows adding conditions, in this case ```buildOptional```


// Fixed version:
@resultBuilder
struct FixedBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined()
    }
    
    static func buildOptional(_ component: String?) -> String {
        component ?? ""
    }
}

// Question 4: What's the difference between buildOptional and buildEither?
// When is each used?
// Answer: buildOptional is for expressions that do not require an else clause, meanwhile buildEither is used for if / else and switch statements.

// Question 5: Implement buildArray to support for loops

@resultBuilder
struct ArrayBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }
    
    static func buildArray(_ components: [String]) -> String {
        return components.joined(separator: "\n")
    }
}

// This should work:
@ArrayBuilder
func listItems() -> String {
    for i in 1...3 {
        "Item \(i)"
    }
}

//print(listItems())
// Expected output:
// Item 1
// Item 2
// Item 3
