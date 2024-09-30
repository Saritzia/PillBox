import SwiftUI

// MARK: - Add button protocol
protocol AddButtonDelegateContract {
    @MainActor
    func addAction(name: String)
}

struct AddButton: View {
    @State private(set) var showingAlert = false
    @State private var name = ""
    private let constans = Constants()
    private var alertTitle: String
    private var delegate: AddButtonDelegateContract?
    
    init(alertTitle: String, delegate: AddButtonDelegateContract?) {
        self.alertTitle = alertTitle
        self.delegate = delegate
    }
    
    var body: some View {
        Button(action: {
            showingAlert.toggle()
        }, label: {
            Image(systemName: constans.plus)
                .resizable()
                .padding(5)
                .frame(width: 20,height: 20)
                .background(.white)
                .clipShape(.circle)
                .foregroundStyle(.black)
                .bold()
        }).alert(alertTitle, isPresented: $showingAlert) {
            TextField(alertTitle, text: $name)
            Button(String(localized: "OK")) {
                delegate?.addAction(name: name)
                self.name = ""
            }
        }
    }
}
// MARK: - Constants
private extension AddButton {
    struct Constants {
        let plus = "plus"
    }
}
