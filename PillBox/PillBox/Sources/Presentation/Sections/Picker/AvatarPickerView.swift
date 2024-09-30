import SwiftUI

protocol AvatarPickerProtocol {
    var images: [String] { get }
    func updateAvatar(avatar: String, cellId: String)
}

struct AvatarPickerView: View {
    @State private var selection: Int = 0
    private var delegate: AvatarPickerProtocol
    private var cellId: String
    
    init(delegate: AvatarPickerProtocol, cellId: String) {
        self.delegate = delegate
        self.cellId = cellId
    }
    
    var body: some View {
        Menu("avatarTitle", systemImage: "filemenu.and.cursorarrow") {
            Picker("", selection: $selection) {
                ForEach(0..<delegate.images.count, id: \.self) { index in
                    Image(delegate.images[index]).resizable()
                }.onDisappear {
                    delegate.updateAvatar(avatar: delegate.images[selection], cellId: cellId)
                }
            }
        }.tint(.black)
        Image(delegate.images[selection])
            .resizable()
            .frame(width: 150, height: 150, alignment: .center)
    }
}
