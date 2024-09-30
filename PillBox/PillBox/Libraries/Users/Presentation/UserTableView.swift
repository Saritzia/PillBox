import SwiftUI

struct UserTableView: View {
    @ObservedObject var userTableViewModel: UserTableViewModel
    
    init(userTableViewModel: UserTableViewModel) {
        self.userTableViewModel = UserTableViewModel()
    }
    
    var body: some View {
        ReusableTableView(title: String(localized: "users"),
                          backButtonIsHidden: true,
                          cells: userTableViewModel.cellModels ?? [],
                          alertTitle:String(localized: "userAlertTitle"),
                          delegate: userTableViewModel,
                          avatarPickerDelegate: userTableViewModel,
                          swipableCellDelegate: userTableViewModel)
    }
}

