# Apple App Store Compliance Declaration

**Target Audience:** Apple App Review Team

**Entitlement:** `com.apple.developer.family-controls`

**App Review Notes Statement:**
"FocusLock utilizes the Family Controls entitlement and Managed Settings framework. 

The application uses these APIs to help adults self-manage their screen time by temporarily shielding apps they find distracting. We utilize `AuthorizationCenter.shared.requestAuthorization(for: .individual)` specifically for adult self-control.

All application shielding relies entirely on Apple's opaque `ApplicationToken` structures. FocusLock does not identify, collect, or transmit the names of the applications installed on the user's device. Shielding logic operates entirely locally."
