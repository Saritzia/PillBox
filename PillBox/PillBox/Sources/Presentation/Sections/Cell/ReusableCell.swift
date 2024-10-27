import SwiftUI

struct CellModel: Equatable, Identifiable {
    let id: String
    let title: String
    var avatar: String
}

struct ReusableCell: View {
    @State private var sheetPresented = false
    @State private var selection: Int = 0
    private var cellModel: CellModel
    private var delegate: AvatarPickerProtocol
    
    init(cellModel: CellModel, delegate: AvatarPickerProtocol) {
        self.cellModel = cellModel
        self.delegate = delegate
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(cellModel.avatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .onTapGesture {
                        sheetPresented = true
                    }
                    .sheet(isPresented: $sheetPresented) {
                        AvatarPickerView(images: delegate.images, selection: $selection)
                    }
                    .onChange(of: selection) {
                        delegate.updateAvatar(avatar: delegate.images[selection], cellId: cellModel.id)
                        sheetPresented = false
                    }
            Text(cellModel.title)
            Spacer()
        }
        .padding()
    }
}
