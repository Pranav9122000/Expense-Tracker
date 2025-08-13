//
//  APIError.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 28/07/25.
//

import Foundation

struct APIError {

    func handleAPIErrorForViewModel<T>(
        _ error: Error,
        loadingState: inout LoadingState<T>,
        errorMessage: inout String,
        isError: inout Bool,
        defaultMessage: String = "Something went wrong. Please try again."
    ) {
        if let apiError = error as? APIErrorResponseModel {
            loadingState = .failed(apiError.message)
            errorMessage = apiError.message
        } else {
            loadingState = .failed(defaultMessage)
            errorMessage = defaultMessage
        }
        isError = true
    }
}
