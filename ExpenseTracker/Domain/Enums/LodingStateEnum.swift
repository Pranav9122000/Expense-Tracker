//
//  LodingStateEnum.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 27/07/25.
//

import Foundation

enum LoadingState<T>: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(String)

    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return false
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
