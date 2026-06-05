# Migration Recovery

If an SQLite schema migration fails in `AppDatabase`, the app does not crash.
1. The database is moved to quarantine mode.
2. A crash report is sent to Firebase Crashlytics.
3. The app fetches the latest healthy snapshot from Firestore `backups/`.
4. Restores local configuration seamlessly.
