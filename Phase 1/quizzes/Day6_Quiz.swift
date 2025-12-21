//
//  Day6_Quiz.swift
//  Phase 1
//
//  Created by specktro on 21/12/25.
//

// Quiz 6.1 - Swift Concurrency
// Name: @specktro

// Question 1: What's the difference between async and throws?
// When would you use each?
// Answer: Async is used to mark a function or property as something could take some time and the system could wait and use its resources til' the function accomplish its task, throws is just for denote that some function could fail with some error
//

// Question 2: What does @MainActor do and why is it needed?
// Answer: The @MainActor is used to mark the classes, structs or functions that has to be executed in the main thread, usually related with UI tasks
//

// Question 3: Fix this code - what's wrong?
//func loadData() async -> String {
//    let data = URLSession.shared.data(from: url)  // ❌ Error!
//    return String(data: data, encoding: .utf8) ?? ""
//}

// Fixed version:
//
//func fixedLoadData() async -> String {
//    let data = try? await URLSession.shared.data(from: URL(string: "")!)
//    return String(data: data?.0 ?? Data(), encoding: .utf8) ?? ""
//}

// Question 4: What's the difference between .task and .onAppear?
// Answer: .task is just used for async piece of code executed when the view appears and cancelled when it dissapears, the onAppear is executed without any asynchronous state
//

// Question 5: Implement a type-safe LoadingState enum
enum LoadingState<T> {
    // Your implementation
    // Should support: idle, loading, success(T), failure(Error)
    case idle
    case loading
    case success(T)
    case failure(Error)
}

// Usage example:
//var state: LoadingState<[String]> = .idle

// Test state transitions:
//state = .loading
//state = .success(["A", "B", "C"])
//state = .failure(URLError(.badURL))
