import ManagedSettings
import ManagedSettingsUI
import UIKit

// Task 8.4: Shield Extension conforming to memory constraints and using SF Symbols
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        return createFocusLockShield()
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        return createFocusLockShield()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        return createFocusLockShield()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        return createFocusLockShield()
    }
    
    private func createFocusLockShield() -> ShieldConfiguration {
        // SF Symbols and System Colors
        return ShieldConfiguration(
            backgroundColor: UIColor.systemBackground,
            icon: UIImage(systemName: "lock.shield.fill"), // Task 8.4: SF Symbol
            title: ShieldConfiguration.Label(text: "FocusLock", color: UIColor.label),
            subtitle: ShieldConfiguration.Label(text: "Discipline is choosing between what you want now, and what you want most.", color: UIColor.secondaryLabel),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Close App", color: UIColor.systemBackground),
            primaryButtonBackgroundColor: UIColor.systemBlue,
            secondaryButtonLabel: nil // Hidden for strictness
        )
    }
}
