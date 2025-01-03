enum ViewState {
    case error(action: (() -> Void))
    case render
    case update(model: DrugModel)
    case permissionError(action: (() -> Void))
}
