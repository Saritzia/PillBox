import SwiftUI

struct CustomButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    init(title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
            Button(title) {
                action()
            }
            .padding(15)
            .frame(width: 250)
            .tint(.white)
            .bold()
            .background(.black)
            .clipShape(.capsule)
    }
}
