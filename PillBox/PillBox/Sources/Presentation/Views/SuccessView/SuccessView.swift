import SwiftUI

struct SuccessView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ImageAndLabels(imageName: "JiraffeSuccessImage",
                       title: "SuccessTitle",
                       description: "SuccessDescription")
        Spacer()
        Divider()
        CustomButton(title: "SuccessButton") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    SuccessView()
}
