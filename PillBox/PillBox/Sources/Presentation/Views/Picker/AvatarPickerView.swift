import SwiftUI

protocol AvatarPickerProtocol {
    var images: [String] { get }
    func updateAvatar(avatar: String, cellId: String)
}

struct AvatarPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selection: Int
    private let images: [String]
    
    init(images: [String], selection: Binding<Int>) {
        self.images = images
        self._selection = selection
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Menu("AvatarTitle", systemImage: "filemenu.and.cursorarrow") {
                Picker("", selection: $selection) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index]).resizable()
                    }
                }
            }
            .tint(.black)
            Image(images[selection])
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            CustomButton(title: "OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
