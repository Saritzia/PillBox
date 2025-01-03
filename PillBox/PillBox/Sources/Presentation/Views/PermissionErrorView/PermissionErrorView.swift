import SwiftUI

struct PermissionErrorView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var router: Router
    private var action: (() -> Void)
    private var view: DrugConfigurationView
    
    init(action: @escaping () -> Void, view: DrugConfigurationView) {
        self.action = action
        self.view = view
    }
    
    var body: some View {
        ImageAndLabels(imageName: "JiraffeErrorIcon",
                       title: "PermissionErrorTitle",
                       description: "PermissionErrorDescription")
        Spacer()
        Divider()
        VStack(alignment: .center, spacing: 10) {
            CustomButton(title: "Settings") {
                action()
            }
            CustomButton(title: "Exit") {
                router.navigate(to: .userTableView)
            }
        }
        .onChange(of: scenePhase, { _, newValue in
            switch newValue {
            case .active:
                Task {
                    if await !view.drugsConfiguratioViewModel.notificationPermissionDenied {
                        view.drugsConfiguratioViewModel.viewState = .render
                    }
                }
            default:
                break
            }
        })
    }
}
