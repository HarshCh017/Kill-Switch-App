# Google Play Store Compliance Document

## Target API: UsageStatsManager & System Alert Window

When submitting FocusLock to the Google Play Store, the reviewing team will flag the application due to its use of high-risk permissions.

You **must** supply this exact justification in the Google Play Console under the App Content -> Permissions section.

### Core Functionality Justification

**Permission:** `android.permission.PACKAGE_USAGE_STATS`
**Permission:** `android.permission.SYSTEM_ALERT_WINDOW`
**Permission:** `android.permission.FOREGROUND_SERVICE_SPECIAL_USE`

**Explanation for Reviewer:**
"FocusLock is a Digital Wellbeing and Productivity application designed to help users overcome smartphone addiction by voluntarily blocking distracting applications. 

To achieve this core functionality:
1. We require `PACKAGE_USAGE_STATS` (specifically `UsageStatsManager.queryEvents()`) to detect when a user launches an application they have explicitly chosen to block.
2. We require `SYSTEM_ALERT_WINDOW` to draw a blocking screen over the distracting application, preventing the user from interacting with it until their focus session expires.
3. We require `FOREGROUND_SERVICE_SPECIAL_USE` to actively maintain the focus session while the app is in the background.

This functionality is the primary purpose of the application. No usage data is sold or transmitted off the device to third parties."

### Video Proof Requirement
You must record a video showing:
1. The user selecting an app to block in FocusLock.
2. The user attempting to open the blocked app from the Android Launcher.
3. The FocusLock overlay successfully intercepting and blocking access.

Link this YouTube/Drive video in the Play Console declaration.
