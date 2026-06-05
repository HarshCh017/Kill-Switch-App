# FocusLock v1.0.0 Release Checklist

## 1. Engineering Sign-off
- [ ] Drift database migrations configured and tested.
- [ ] Offline sync idempotent retry logic verified.
- [ ] iOS Shield Extension uses less than 50MB of memory.
- [ ] Android AppMonitor Foreground Service survives OS reboot.

## 2. QA Sign-off
- [ ] E2E Android Test: Verify App Overlay appears within 100ms of launching a blocked app.
- [ ] E2E iOS Test: Verify native Shield appears and cannot be bypassed.
- [ ] Verify Server-side receipt validation rejects spoofed purchases.
- [ ] Verify `Support Bundle` generates cleanly with permissions status.

## 3. Store Listing Assets
- [ ] Generate 1024x1024 App Icon.
- [ ] Generate Android Play Store Screenshots (Phone + Tablet).
- [ ] Generate iOS App Store Screenshots (6.5" and 5.5").
- [ ] Record Android UI demonstration video for Google Play Reviewers (Permissions Declaration).

## 4. Environment Variables
- [ ] Update `Remote Config` defaults in Firebase Console.
- [ ] Ensure `maintenanceMode` is set to false.

## 5. Deployment
- [ ] Tag git commit `v1.0.0`.
- [ ] Push tag to trigger `android-build.yml` and `ios-build.yml`.
- [ ] Download `.aab` from GitHub Actions, sign, and upload to Play Console.
- [ ] Verify TestFlight build processed successfully in App Store Connect.
