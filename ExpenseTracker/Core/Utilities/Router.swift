//
//  Router.swift
//  ExpenseTracker
//
//  Created by Pranav.kulkarni on 19/07/25.
//

import Foundation
import SwiftUI

public class AnyIdentifable: Identifiable {
    public let destination: any Identifiable
    
    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

public final class Router<T: Hashable>: ObservableObject {
    
    @Published public var navPath = NavigationPath()
    @Published public var presentedSheet: AnyIdentifable?
    
    public init() { }
    
    public func presentSheet(_ destination: AnyIdentifable) {
        presentedSheet = AnyIdentifable(destination: destination)
    }
    
    public func navigate(to destination: T) {
        navPath.append(destination)
    }
    
    public func navigateBack() {
        navPath.removeLast()
    }
    
    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
