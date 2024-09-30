import SwiftUI

struct CellModel: Equatable, Identifiable {
    let id: String
    let title: String
    var avatar: String
}

struct ReusableCell: View {
    @State private var isPresented: Bool = false
    private var cellModel: CellModel
    private var delegate: AvatarPickerProtocol
    
    init(cellModel: CellModel, delegate: AvatarPickerProtocol) {
        self.cellModel = cellModel
        self.delegate = delegate
    }
    
    var body: some View {
        HStack(spacing: 10) {
            NavigationStack {
                Image(cellModel.avatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .onTapGesture {
                        isPresented = true
                    }
            }
            .navigationDestination(isPresented: $isPresented) {
                VStack(spacing: 50) {
                    AvatarPickerView(delegate: delegate, cellId: cellModel.id)
                    Button(String(localized: "Seleccionar")) {
                        isPresented = false
                    }
                    .padding()
                    .background(.black)
                    .foregroundStyle(.white)
                    .bold()
                    .clipShape(.capsule)
                }
            }
            Text(cellModel.title)
            Spacer()
        }
        .padding()
    }
}
