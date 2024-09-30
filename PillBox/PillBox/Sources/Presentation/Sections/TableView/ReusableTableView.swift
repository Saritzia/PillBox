import SwiftUI

protocol SwipableCellDelegateContract {
    func onSwipe(id: String)
}

enum Step {
    case user
    case drug
}

struct ReusableTableView: View {
    private let constants = Constants()
    private let title: String
    private let backButtonIsHidden: Bool
    private let cells: [CellModel]
    private let alertTitle: String
    private let delegate: AddButtonDelegateContract?
    private let avatarPickerDelegate: AvatarPickerProtocol
    private let swipableCellDelegate: SwipableCellDelegateContract
    private let step: Step
    
    init(title: String,
         backButtonIsHidden: Bool,
         cells: [CellModel],
         alertTitle: String,
         delegate: AddButtonDelegateContract?,
         avatarPickerDelegate: AvatarPickerProtocol,
         swipableCellDelegate: SwipableCellDelegateContract,
         step: Step) {
        self.title = title
        self.backButtonIsHidden = backButtonIsHidden
        self.cells = cells
        self.alertTitle = alertTitle
        self.delegate = delegate
        self.avatarPickerDelegate = avatarPickerDelegate
        self.swipableCellDelegate = swipableCellDelegate
        self.step = step
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(cells) { cellModel in
                    NavigationLink {
                        switch step {
                        case .user:
                            DrugsTableView(drugTableViewModel: DrugsTableViewModel(user: cellModel.title))
                        case .drug:
                            DrugConfigurationView()
                        }
                    } label: {
                        ReusableCell(cellModel: cellModel, delegate: avatarPickerDelegate)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                swipableCellDelegate.onSwipe(id: cellModel.id)
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
                    AddButton(alertTitle: alertTitle, delegate: delegate)
                }
            })
        }
        .tint(.white)
    }
}

extension ReusableTableView {
    struct Constants {
        let trash = "trash"
    }
}
