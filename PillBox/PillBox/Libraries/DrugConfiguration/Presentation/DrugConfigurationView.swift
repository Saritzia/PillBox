import SwiftUI

struct DrugConfigurationView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var drugsConfiguratioViewModel: DrugsConfigurationViewModel
    @State private var isToogleOn: Bool = false
    @State private var numberOfTime = 1
    @State private var timeUnit = 1
    @State private var endDate = Date()
    @State private var otherInformation = ""
    @State private var drugName = ""
    
    init(drugsConfiguratioViewModel: DrugsConfigurationViewModel) {
        self.drugsConfiguratioViewModel = drugsConfiguratioViewModel
    }
    
    func setupConfiguration(with model: DrugModel) {
        isToogleOn = model.isToogleOn
        numberOfTime = model.numberOfTimes ?? 1
        timeUnit = model.timeUnit ?? 1
        endDate = model.endDate ?? Date()
        drugName = model.drug ?? ""
        otherInformation = model.otherInformation ?? ""
    }
    
    var body: some View {
        switch drugsConfiguratioViewModel.viewState {
        case .error(let action):
            ErrorView(action: action)
        case .render:
            renderView
        case .update(let model):
            renderView.onAppear {
                setupConfiguration(with: model)
            }
        }
    }
}
// MARK: - Render view
private extension DrugConfigurationView {
    var renderView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Label("DrugName", image: "")
                    .foregroundStyle(.black)
                    .bold()
                TextField("DrugAlertTitle", text: $drugName)
                    .textFieldStyle(.roundedBorder)
                    .background(.gray)
                Toggle(isOn: $isToogleOn) {
                    Label("Notifications", image: "")
                        .foregroundStyle(.black)
                        .bold()
                }
                .tint(.green)
                HStack(spacing: 20) {
                    Label("Frequency", image: "")
                        .foregroundStyle(.black)
                        .bold()
                    Spacer()
                    Picker(selection: $numberOfTime, label: Text("Frequency")) {
                        ForEach(1...12, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .tint(.black)
                    Picker(selection: $timeUnit, label: Text("PeriodOfTime")) {
                        Text("Hours").tag(1)
                        Text("Days").tag(2)
                        Text("Months").tag(3)
                        Text("Year").tag(4)
                    }
                    .tint(.black)
                }
                Label("EndDate", image: "")
                    .foregroundStyle(.black)
                    .bold()
                DatePicker("EndDate", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .tint(.red)
                TextField("OtherInformation", text: $otherInformation)
                    .textFieldStyle(.roundedBorder)
                    .background(.gray)
            }
            .padding()
            Spacer()
            VStack {
                Divider()
                CustomButton(title: "SaveConfiguration") {
                    let model = DrugModel(drug: drugName,
                                          endDate: endDate,
                                          isToogleOn: isToogleOn,
                                          numberOfTimes: numberOfTime,
                                          timeUnit: timeUnit,
                                          otherInformation: otherInformation)
                    drugsConfiguratioViewModel.saveDrug(with: model)
                    router.navigate(to: .successScreen)
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Configuration")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.white)
            }
        })
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.black, for: .navigationBar)
    }
}

#Preview {
    DrugConfigurationView(drugsConfiguratioViewModel: DrugsConfigurationViewModel(userId: "", drugId: nil))
}
