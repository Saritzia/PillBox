import SwiftUI

@main
struct PillBoxApp: App {
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                ContentView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .userTableView:
                            UserTableView(userTableViewModel: UserTableViewModel())
                        case .drugTableView(let id):
                            DrugsTableView(drugTableViewModel: DrugsTableViewModel(userId: id))
                        case .successScreen:
                            SuccessView()
                        case let .drugConfiguration(userId, drugId):
                            DrugConfigurationView(drugsConfiguratioViewModel: DrugsConfigurationViewModel(userId: userId,
                                                                                                          drugId: drugId))
                        }
                    }
            }
            .environmentObject(router)
            .tint(.white)
        }
    }
}
