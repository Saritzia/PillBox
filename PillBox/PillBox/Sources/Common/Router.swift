import SwiftUI

final class Router: ObservableObject {
    enum Destination: Hashable {
        case userTableView
        case drugTableView(id: String)
        case successScreen
        case errorScreen
        case drugConfiguration
    }
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}


