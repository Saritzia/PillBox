import SwiftUI

struct SuccessView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ImageAndLabels(imageName: "JiraffeSuccessImage",
                       title: "SuccessTitle",
                       description: "SuccessDescription")
        Spacer()
        Divider()
        CustomButton(title: "SuccessButton") {
            router.navigateBackBeforeSuccess()
        }
    }
}

#Preview {
    SuccessView()
}
