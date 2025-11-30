//
//  ToDoListView.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//

import SwiftUI

struct ToDoListView: View {
    @State private var newTodo: String = ""
    @State private var todos: [Todo] = Todo.samples
    
    var body: some View {
        List {
            Section {
                AddTodoField(newTodo: $newTodo)
            }
            
            Section {
                ForEach($todos) { $todo in
                    TodoCard(todo: $todo)
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        todos.remove(at: index)
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
