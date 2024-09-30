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
        Picker(selection: $selection) {
            ForEach(0..<delegate.images.count, id: \.self) { index in
                Image(delegate.images[index])
            }.onDisappear {
                delegate.updateAvatar(avatar: delegate.images[selection], cellId: cellId)
            }
        } label: {
            Text("avatarTitle")
        }
        .pickerStyle(.menu)
        .tint(.black)
    }
}
