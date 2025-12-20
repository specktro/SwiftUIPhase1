import Foundation

// 1. Simple property wrapper
@propertyWrapper
struct Trimmed {
    private var value: String = ""
    
    var wrappedValue: String {
        get {
            value
        }
        
        set {
            value = newValue.trimmingCharacters(in: .whitespaces)
        }
    }
}

struct Form {
    @Trimmed var username: String
}

var form = Form()
form.username = "  john  "
print("'\(form.username)'") // 'john'


// 2. Property wrapper with storage
@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    private let range: ClosedRange<T>
    
    var wrappedValue: T {
        get {
            value
        }
        
        set {
            value = min(max(range.lowerBound, newValue), range.upperBound)
        }
    }
    
    init(wrappedValue: T, _ range: ClosedRange<T>) {
        self.range = range
        self.value = min(max(range.lowerBound, wrappedValue), range.upperBound)
    }
}

struct Game {
    @Clamped(0...100) var health: Int = 50
}

var game = Game()
game.health = 150
print(game.health) // 100
game.health = -10
print(game.health) // 0


// 3. Property wrapper with projected value
@propertyWrapper
struct Logged<T> {
    private var value: T
    private(set) var history: [T] = []
    
    var wrappedValue: T {
        get {
            value
        }
        
        set {
            history.append(newValue)
            value = newValue
        }
    }
    
    var projectedValue: [T] {
        history
    }
    
    init(wrappedValue: T) {
        self.value = wrappedValue
        self.history = [wrappedValue]
    }
}

struct Counter {
    @Logged var count: Int = 0
}

var counter = Counter()
counter.count = 1
counter.count = 2
counter.count = 3
print(counter.$count) // [0, 1, 2, 3]
