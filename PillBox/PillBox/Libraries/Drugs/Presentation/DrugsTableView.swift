import SwiftUI

struct DrugsTableView: View {
    @ObservedObject var drugTableViewModel: DrugsTableViewModel
    
    var body: some View {
        ReusableTableView(title: String(localized: "drugs"),
                          backButtonIsHidden: false,
                          cells: drugTableViewModel.cellModels ?? [],
                          alertTitle: String(localized: "drugAlertTitle"),
                          delegate: drugTableViewModel,
                          avatarPickerDelegate: drugTableViewModel,
                          swipableCellDelegate: drugTableViewModel,
                          step: .drug)
    }
}
