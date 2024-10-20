import SwiftUI

struct UserTableView: View {
    @ObservedObject var userTableViewModel: UserTableViewModel
    
    init(userTableViewModel: UserTableViewModel) {
        self.userTableViewModel = UserTableViewModel()
    }
    private let constants = Constants()
    private var cells: [CellModel] {
        userTableViewModel.cellModels ?? []
    }

    var body: some View {
        NavigationStack {
            List{
                ForEach(cells) { cellModel in
                    NavigationLink {
                        DrugsTableView(drugTableViewModel: DrugsTableViewModel(userId: cellModel.id))
                    } label: {
                        ReusableCell(cellModel: cellModel, delegate: userTableViewModel)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                userTableViewModel.onSwipe(id: cellModel.id)
                            } label: {
                                Label("Delete", systemImage: constants.trash).tint(.red)
                            }
                        }
                        .frame(height: 50)
                        .scaledToFit()
                    }
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
        .tint(.white)
    }
}

extension UserTableView {
    struct Constants {
        let trash = "trash"
    }
}


