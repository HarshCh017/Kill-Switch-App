# FocusLock v1.0.0-rc1 Release Checklist

## 1. Automated Validation
- [ ] `flutter analyze` passing with 0 warnings.
- [ ] `flutter test` passing with >80% coverage.
- [ ] `integration_test` passing on Firebase Test Lab.

## 2. Manual QA Validation
- [ ] Android OEM tests completed (Samsung, Xiaomi).
- [ ] iOS Physical Device tests completed.
- [ ] Support Bundle generator verified.

## 3. Security Audit
- [ ] `validateReceipt` Cloud Function deployed and tested.
- [ ] `flutter_secure_storage` verified to persist PIN across reboots.
- [ ] Drift `SyncQueue` gracefully handles offline writes and network drops without duplicating records.

## 4. Store Operations
- [ ] Generate App Icons (1024x1024).
- [ ] Upload Android Permissions Declaration Video.
- [ ] Input Apple App Review Notes.
- [ ] Set `maintenanceMode` = `false` in Firebase Remote Config.
- [ ] Push Git Tag `v1.0.0-rc1` to trigger release workflows.
