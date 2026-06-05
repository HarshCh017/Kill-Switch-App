# Apple App Store Compliance Document

## Target API: Screen Time / Family Controls

FocusLock utilizes Apple's strictly controlled Screen Time API frameworks (`FamilyControls`, `ManagedSettings`, `DeviceActivity`).

### Entitlement Approval
You cannot submit the app to App Store Connect until Apple explicitly approves the `FamilyControls` entitlement for your Organization's Apple Developer Account. 
If you have not submitted the form (as described in Milestone 0), do so immediately.

### App Review Justification

When submitting FocusLock, include the following in the App Review Notes:

**Explanation for Reviewer:**
"FocusLock is a productivity application that utilizes the Family Controls entitlement and Managed Settings framework. 

The application uses these APIs to help adults self-manage their screen time by temporarily shielding apps they find distracting. We utilize `AuthorizationCenter.shared.requestAuthorization(for: .individual)` specifically for adult self-control, as permitted by Apple's Screen Time guidelines. 

All application shielding relies entirely on opaque `ApplicationToken` structures. At no point does FocusLock attempt to identify, collect, or transmit the names of the applications installed on the user's device."
