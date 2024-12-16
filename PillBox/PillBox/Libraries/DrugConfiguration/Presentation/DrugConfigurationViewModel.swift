import Foundation
import RealmSwift
import UIKit
import UserNotifications

final class DrugsConfigurationViewModel: ObservableObject {
    @Published var drugModel: DrugModel?
    @Published var viewState: ViewState = .render
    private(set) var userId: String
    private let drugId: String?
    private let drugsDataManagementUseCase: DrugsDataManagementUseCaseContract
    private var currentTask: Task<Void, Error>?
    private let center = UNUserNotificationCenter.current()
    
    init(userId: String, drugId: String? = nil) {
        self.userId = userId
        self.drugId = drugId
        self.drugsDataManagementUseCase = DrugsDataManagementUseCase()
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.fetchData()
        }
    }
    
    @MainActor
    func fetchData() {
        Task {
            await askForPermission()
            viewState = .render
            guard let drugId else {
                viewState = .render
                return
            }
            if let drugModel = self.fetchDrugs(user: self.userId)?.filter({ $0.idDrug == drugId }).first {
                viewState = .update(model: drugModel)
            }
        }
    }
    
    @MainActor
    func saveDrug(with model: DrugModel) {
        if let drugId {
            let newConfigurationModel = DrugModel(idDrug: drugId,
                                                  drug: model.drug,
                                                  endDate: model.endDate,
                                                  isToogleOn: model.isToogleOn,
                                                  numberOfTimes: model.numberOfTimes,
                                                  timeUnit: model.timeUnit,
                                                  otherInformation: model.otherInformation)
            saveConfiguration(drugModel: newConfigurationModel, userId: userId)
        } else {
            saveData(drugModel: model, userId: userId)
        }
        model.isToogleOn ? sendNotifications(with: model) : deleteNotificationsQueue(with: model)
    }
    
    var notificationPermissionDenied: Bool {
        /// Obtain the notification settings.
        get async {
            await center.notificationSettings().authorizationStatus == .denied
        }
    }
    
    func showPermissionError() {
        viewState = .permissionError(action: {
            if let url = URL(string:UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
    }
}

private extension DrugsConfigurationViewModel {
    func fetchDrugs(user: String) -> [DrugModel]? {
        drugsDataManagementUseCase.fetchDrugs(user: user)
    }
    
    func saveData(drugModel: DrugModel, userId: String) {
        do {
            try drugsDataManagementUseCase.saveData(drug: drugModel, user: userId)
        } catch {
            viewState = .error { [weak self] in
                self?.saveData(drugModel: drugModel, userId: userId)
            }
        }
    }
    
    func saveConfiguration(drugModel: DrugModel, userId: String) {
        do {
            try drugsDataManagementUseCase.updateConfiguration(user: userId, drug: drugModel)
        } catch {
            viewState = .error { [weak self] in
                self?.saveConfiguration(drugModel: drugModel, userId: userId)
            }
        }
    }
}
// MARK: - Notifications methods
private extension DrugsConfigurationViewModel {
    func askForPermission() async {
        do {
            try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            viewState = .error { [weak self] in
                Task {
                    await self?.fetchData()
                }
            }
        }
    }
    
    
    func sendNotifications(with model: DrugModel) {
        // Notification content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "NotificationTitle", arguments: nil)
        content.body = model.drug ?? ""
        content.sound = UNNotificationSound.default
        // Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: calculateTimeInterval(with: model), repeats: true)
        // Do the request
        let request = UNNotificationRequest(identifier: userId + (model.idDrug ?? ""), content: content, trigger: trigger)
        center.add(request)
    }
    
    func deleteNotificationsQueue(with model: DrugModel) {
        if let drug = model.drug {
            center.removePendingNotificationRequests(withIdentifiers: [drug])
        }
    }
    
    func calculateTimeInterval(with model: DrugModel) -> Double {
        Double((model.numberOfTimes ?? 1) * calculateTimeUnit(unit: model.timeUnit))
    }
    
    /// This method returns the number of second for each time unit
    func calculateTimeUnit(unit: Int?) -> Int {
        switch unit {
            /// Hour = minutes * seconds
        case 1:
            60 * 60
            /// Day = hours per day * minutes * seconds
        case 2:
            24 * 60 * 60
            /// Month = days * hours per day * minutes * seconds
        case 3:
            30 * 24 * 60 * 60
            /// Year = number of days * hours per day * minutes * seconds
        default:
            365 * 24 * 60 * 60
        }
    }
}
