import SwiftUI

struct DrugsTableView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var drugTableViewModel: DrugsTableViewModel
    private let constants = Constants()
    private var cells: [CellModel] {
        drugTableViewModel.cellModels ?? []
    }
    
    init(drugTableViewModel: DrugsTableViewModel) {
        self.drugTableViewModel = drugTableViewModel
    }
    
    var body: some View {
        switch drugTableViewModel.viewSate {
        case .render:
            renderView
        case .error(let action):
            ErrorView(action: action)
        }
    }
}

// MARK: - Constants
extension DrugsTableView {
    struct Constants {
        let trash = "trash"
    }
}

// MARK: - Render view
private extension DrugsTableView {
    var renderView: some View {
        List(cells) { cellModel in
            ReusableCell(cellModel: cellModel, delegate: drugTableViewModel)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        drugTableViewModel.onSwipe(id: cellModel.id)
                    } label: {
                        Label("Delete", systemImage: constants.trash).tint(.red)
                    }
                }
                .frame(height: 50)
                .scaledToFill()
                .onTapGesture {
                    router.navigate(to: .drugConfiguration)
                }
        }
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(String(localized: "Drugs"))
                    .colorInvert()
                    .bold()
                    .font(.title3)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.black, for: .navigationBar)
        .listItemTint(.black)
        .navigationBarBackButtonHidden(false)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    router.navigate(to: .drugConfiguration)
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(5)
                        .frame(width: 20,height: 20)
                        .background(.white)
                        .clipShape(.circle)
                        .foregroundStyle(.black)
                        .bold()
                })
            }
        })
        .tint(.white)
    }
}
