enum ViewState {
    case error(action: (() -> Void))
    case render
}
