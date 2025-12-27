import Foundation

// 1. Basic async function
func fetchNumber() async -> Int {
    try? await Task.sleep(for: .seconds(1))
    return 42
}

Task {
    let number = await fetchNumber()
    print("Got number: \(number)")
}

// 2. Throwing async function
func fetchData() async throws -> String {
    try await Task.sleep(for: .seconds(1))
    
    if Bool.random() {
        throw URLError(.badServerResponse)
    }
    
    return "Success!"
}

Task {
    do {
        let data = try await fetchData()
        print("Data: \(data)")
    } catch {
        print("Error: \(error)")
    }
}

// 3. Parallel execution
func fetchMultiple() async {
    async let first = fetchNumber()
    async let second = fetchNumber()
    async let third = fetchNumber()
    
    let results = await [first, second, third]
    print("All: \(results)")
}

Task {
    await fetchMultiple()
}

// 4. Task cancellation
let task = Task {
    for i in 1...10 {
        try Task.checkCancellation()
        print("Working: \(i)")
        try await Task.sleep(for: .seconds(0.5))
    }
}

Task {
    try await Task.sleep(for: .seconds(2))
    task.cancel()
    print("Cancelled!")
}
