# Android OEM Testing Protocols

Because Android manufacturers aggressively kill background services to save battery, FocusLock must be manually tested across these specific OEM devices before Release Candidate sign-off.

## 1. Samsung (OneUI)
- **Constraint:** "Deep Sleeping Apps" feature aggressively kills foreground services.
- **Testing:** Verify `DiagnosticsScreen` flags Battery Optimization as disabled. Schedule a block, turn screen off for 30 minutes, turn screen on, launch blocked app. Verify overlay appears < 100ms.

## 2. Xiaomi (MIUI / HyperOS)
- **Constraint:** MIUI requires a specific "Display pop-up windows while running in the background" permission that is distinctly separate from the standard Android `SYSTEM_ALERT_WINDOW`.
- **Testing:** Attempt to trigger overlay while the app is swiped away from recents.

## 3. Pixel (AOSP / Pixel UI)
- **Constraint:** Baseline Android behavior.
- **Testing:** Standard E2E test suite. Verify `UsageStatsManager` detects `MOVE_TO_FOREGROUND` reliably.

## 4. Oppo / Vivo / Realme (ColorOS / FuntouchOS)
- **Constraint:** Aggressive "Auto-Launch" restrictions.
- **Testing:** Restart device. Ensure `BootReceiver` fires and successfully resurrects `AppMonitorForegroundService` without manual user interaction.
