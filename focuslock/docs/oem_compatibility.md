# OEM Compatibility

Android manufacturers heavily alter background execution limits.
- **Samsung/Xiaomi/Oppo/Vivo:** Provide an in-app "Diagnostics" screen that routes users directly to OEM battery optimization settings to whitelist the application.
- `DiagnosticsService` actively checks `isBatteryOptimizationDisabled` to ensure reliability.
