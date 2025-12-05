//
//  Todo.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//

import Foundation

struct Todo: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool
    
    static var samples: [Todo] {
        return [Todo(title: "Buy groceries", isCompleted: false), Todo(title: "Read a book", isCompleted: false), Todo(title: "Finish homework", isCompleted: false), Todo(title: "Call mom", isCompleted: false), Todo(title: "Red Chapter S", isCompleted: false), Todo(title: "Write report", isCompleted: false), Todo(title: "Watch Better Call Saul", isCompleted: false)]
    }
}
