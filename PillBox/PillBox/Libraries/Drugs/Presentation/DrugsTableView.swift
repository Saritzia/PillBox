import SwiftUI

struct DrugsTableView: View {
    @ObservedObject var drugTableViewModel: DrugsTableViewModel
    private let constants = Constants()
    private let title: String = String(localized: "drugs")
    private let backButtonIsHidden: Bool = false
    private var cells: [CellModel] {
        drugTableViewModel.cellModels ?? []
    }
    private let alertTitle: String = String(localized: "drugAlertTitle")
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(cells) { cellModel in
                    NavigationLink {
                        DrugConfigurationView()
                    } label: {
                        ReusableCell(cellModel: cellModel, delegate: drugTableViewModel)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                drugTableViewModel.onSwipe(id: cellModel.id)
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
                    Text(title)
                        .colorInvert()
                        .bold()
                        .font(.title3)
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.black, for: .navigationBar)
            .listItemTint(.black)
            .navigationBarBackButtonHidden(backButtonIsHidden)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    AddButton(alertTitle: alertTitle, delegate: drugTableViewModel)
                }
            })
        }
        .tint(.white)
    }
}

extension DrugsTableView {
    struct Constants {
        let trash = "trash"
    }
}
