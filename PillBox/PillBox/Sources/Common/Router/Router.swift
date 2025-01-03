import SwiftUI

final class Router: ObservableObject {
    enum Destination: Hashable {
        case userTableView
        case drugTableView(id: String)
        case successScreen
        case drugConfiguration(userId: String, drugId: String?)
    }
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateBackBeforeSuccess() {
        navigationPath.removeLast(2)
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}


