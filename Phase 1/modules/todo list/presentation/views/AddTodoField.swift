//
//  AddTodoField.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//


import SwiftUI

struct AddTodoField: View {
    @Binding var newTodo: String
    var addTodo: (Todo) -> Void
    
    var body: some View {
        HStack {
            TextField("New todo...", text: $newTodo)
            Button {
                addTodo(Todo(title: newTodo, isCompleted: false))
                newTodo = ""
            } label: {
                Image(systemName: "plus")
            }
            .foregroundStyle(.blue)
        }
    }
}
