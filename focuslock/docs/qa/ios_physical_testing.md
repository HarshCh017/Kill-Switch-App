# iOS Physical Testing Protocols

Apple's Screen Time APIs (`FamilyControls`, `ManagedSettingsStore`) behave drastically differently in the iOS Simulator compared to a physical device. All QA must be performed on physical hardware.

## 1. Authorization Grant
- **Action:** Open app, tap "Grant Screen Time Access".
- **Expected:** Native iOS modal appears. After accepting, verify the Flutter UI receives the success callback via MethodChannel.

## 2. App Selection
- **Action:** Trigger `FamilyActivityPicker`. Select exactly 3 apps.
- **Expected:** Picker dismisses. 3 opaque tokens are generated.

## 3. Shield Enforcement
- **Action:** Initiate Focus Session. Press Home button. Launch one of the 3 selected apps.
- **Expected:** Native FocusLock Shield appears instantly. Verify the Shield UI matches the `ShieldConfigurationExtension` specs (SF Symbol icon, correct quote, Blue primary button).

## 4. Token Rotation (Edge Case)
- **Action:** Go to iOS Settings -> Screen Time -> FocusLock -> Revoke Access. Open FocusLock app.
- **Expected:** Swift layer detects failure, triggers `onTokensInvalidated` via MethodChannel, and Flutter UI forces the user back to the Authorization screen.
