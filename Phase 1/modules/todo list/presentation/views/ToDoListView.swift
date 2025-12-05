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
    private var remain: Int { todos.reduce(0) { $0 + (!$1.isCompleted ? 1 : 0) } }
    
    var body: some View {
        List {
            Section {
                AddTodoField(newTodo: $newTodo) { newTodo in
                    todos.append(newTodo)
                }
            }
            
            Section {
                if todos.isEmpty {
                    Text("No todo yet!\nAdd one to get started")
                } else {
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
        .navigationBarItems(trailing: Text("\(remain) remain"))
    }
}

#Preview {
    ToDoListView()
}
