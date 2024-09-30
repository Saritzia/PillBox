import Foundation

protocol ReusableTableViewModelContract: ObservableObject {
    var cellModels: [CellModel]? { get set }
    func fetchData()
}

