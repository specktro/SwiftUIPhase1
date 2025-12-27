//
//  AsyncStateMachine.swift
//  Phase 1
//
//  Created by specktro on 21/12/25.
//

import Combine
import Foundation

// MARK: - Loading State
enum LoadingState<T> {
    case idle
    case loading
    case success(T)
    case failure(Error)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var data: T? {
        if case .success(let data) = self {
            return data
        }
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}

// MARK: - Equatable (when T is Equatable)
extension LoadingState: Equatable where T: Equatable {
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let a), .success(let b)):
            return a == b
        case (.failure(let a), .failure(let b)):
            return a.localizedDescription == b.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible
extension LoadingState: CustomStringConvertible {
    var description: String {
        switch self {
        case .idle:
            return "idle"
        case .loading:
            return "loading"
        case .success(let data):
            if let array = data as? any Collection {
                return "success(count: \(array.count))"
            }
            return "success"
        case .failure(let error):
            return "failure(\(error.localizedDescription))"
        }
    }
}
