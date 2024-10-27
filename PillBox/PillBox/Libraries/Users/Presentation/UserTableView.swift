import SwiftUI

struct UserTableView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var userTableViewModel: UserTableViewModel
    private let constants = Constants()
    private var cells: [CellModel] {
        userTableViewModel.cellModels ?? []
    }
    
    init(userTableViewModel: UserTableViewModel) {
        self.userTableViewModel = UserTableViewModel()
    }
    
    var body: some View {
        List(cells) { cellModel in
            ReusableCell(cellModel: cellModel, delegate: userTableViewModel)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        userTableViewModel.onSwipe(id: cellModel.id)
                    } label: {
                        Label("Delete", systemImage: constants.trash).tint(.red)
                    }
                }
                .frame(height: 50)
                .scaledToFill()
                .onTapGesture {
                    router.navigate(to: .drugTableView(id: cellModel.id))
                }
        }
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(String(localized: "users"))
                    .colorInvert()
                    .bold()
                    .font(.title3)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.black, for: .navigationBar)
        .listItemTint(.black)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                AddButton(alertTitle: String(localized: "userAlertTitle"), delegate: userTableViewModel)
            }
        })
    }
}

extension UserTableView {
    struct Constants {
        let trash = "trash"
    }
}


