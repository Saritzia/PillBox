import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var router: Router
    private var action: (() -> Void)
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        ImageAndLabels(imageName: "JiraffeErrorIcon",
                       title: "ErrorTitle",
                       description: "ErrorDescription")
        Spacer()
        Divider()
        VStack(alignment: .center, spacing: 10) {
            CustomButton(title: "Retry") {
                action()
            }
            CustomButton(title: "Exit") {
                router.navigate(to: .userTableView)
            }
        }
    }
}
