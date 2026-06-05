# Architecture Overview

FocusLock uses an offline-first architecture with strict SLAs.

## Layers
1. **Presentation:** Flutter, Riverpod, GoRouter.
2. **Domain:** Entities, Repositories, UseCases.
3. **Data:** Drift (SQLite), Background Sync Queue to Firebase.
4. **Native Core (Android):** Foreground Service, BlockCacheManager, UsageStatsManager, Overlays.
5. **Native Core (iOS):** ScreenTime API (FamilyControls, ManagedSettingsStore), ShieldExtension.

Data strictly flows: UI -> Drift -> Sync Queue -> Firestore.
