# FocusLock (Kill-Switch-App)

FocusLock is a production-grade digital wellbeing application engineered to help users reclaim their time. It utilizes strict OS-level APIs on Android (UsageStatsManager + Overlay) and iOS (FamilyControls) to enforce app-blocking sessions with military precision.

## Architecture
FocusLock strictly follows Clean Architecture and Offline-First principles:
- **Presentation**: Flutter UI with Material 3 styling.
- **Domain**: Pure Dart business logic (`MetricsEngine`, `ScheduleEvaluator`).
- **Data**: Drift (SQLite) database with a robust background SyncQueue.
- **Native**: Kotlin WorkManager and Swift ShieldExtensions.

## Features
- **Strict Mode**: PIN-protected session walls.
- **Offline First**: All blocks persist locally via Drift and sync to Firebase when online.
- **Native Blocking**: O(1) BlockCacheManager ensuring instant app interception on Android.

## Setup
Please refer to `docs/setup_guide.md` for compilation instructions.
