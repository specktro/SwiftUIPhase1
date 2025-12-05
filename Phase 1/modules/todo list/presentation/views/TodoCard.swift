//
//  TodoCard.swift
//  Phase 1
//
//  Created by specktro on 30/11/25.
//

import SwiftUI

struct TodoCard: View {
    @Binding var todo: Todo
    
    var body: some View {
        HStack {
            Button {
                todo.isCompleted.toggle()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(todo.isCompleted ? .secondary : .primary)
        }
    }
}
