//
//  ToDoListView.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//

import SwiftUI

struct ToDoListView: View {
    @State private var newTodo: String = ""
    private var todos: [String] = ["Buy groceries", "Finish homework", "Call mom", "Red Chapter S", "Write report", "Watch Better Call Saul"]
    
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("New todo...", text: $newTodo)
                    Button {
                        // TODO: Action to add a new item into the todo list
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundStyle(.blue)
                }
            }
            
            Section {
                ForEach(todos, id: \.self) { todo in
                    Text(todo)
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
