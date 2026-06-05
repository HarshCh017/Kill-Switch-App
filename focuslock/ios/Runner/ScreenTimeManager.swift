import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import Flutter

@available(iOS 16.0, *)
class ScreenTimeManager {
    static let shared = ScreenTimeManager()
    let store = ManagedSettingsStore()
    var methodChannel: FlutterMethodChannel?

    // Task 8.1 & 8.5: FamilyControls Auth & Token Rotation setup
    func requestAuthorization() {
        AuthorizationCenter.shared.requestAuthorization(for: .individual) { result in
            switch result {
            case .success():
                print("FamilyControls Authorized")
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
                self.dispatchTokenInvalidationEvent() // Task 8.5
            }
        }
    }

    // Task 8.2: Apply Restrictions via ManagedSettings
    func applyShield(selection: FamilyActivitySelection) {
        store.shield.applications = selection.applicationTokens.isEmpty ? nil : selection.applicationTokens
        store.shield.applicationCategories = selection.categoryTokens.isEmpty ? nil : ShieldSettings.ActivityCategoryPolicy.specific(Array(selection.categoryTokens))
    }

    // Task 8.3: Remove restrictions
    func removeShield() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }

    // Task 8.5: Bridging back to Flutter when tokens drop or fail
    private func dispatchTokenInvalidationEvent() {
        DispatchQueue.main.async {
            self.methodChannel?.invokeMethod("onTokensInvalidated", arguments: nil)
        }
    }
}
