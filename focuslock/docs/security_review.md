# Security Review

1. **PIN Security:** Hashes stored using `flutter_secure_storage`.
2. **Purchases:** Receipts validated strictly via Cloud Functions, preventing client-side bypasses.
3. **App Blocking:** Native overlays and shield extensions are built to OS security specifications. No root or jailbreak required.
4. **Data Isolation:** All Drift schemas are fully isolated offline until synced.
