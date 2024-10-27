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
                    Text(String(localized: "drugs"))
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
                    AddButton(alertTitle: String(localized: "drugAlertTitle"), delegate: drugTableViewModel)
                }
            }).tint(.white)
    }
}

extension DrugsTableView {
    struct Constants {
        let trash = "trash"
    }
}
