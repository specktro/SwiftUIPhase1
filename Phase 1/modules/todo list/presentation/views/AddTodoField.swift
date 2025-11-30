//
//  AddTodoField.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//


import SwiftUI

struct AddTodoField: View {
    @Binding var newTodo: String
    
    var body: some View {
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
}
