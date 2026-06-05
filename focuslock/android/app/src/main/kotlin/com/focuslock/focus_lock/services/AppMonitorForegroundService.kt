package com.focuslock.focus_lock.services

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import kotlinx.coroutines.*

class AppMonitorForegroundService : Service() {
    private var isRunning = false
    private val serviceScope = CoroutineScope(Dispatchers.Default + Job())
    private lateinit var usageStatsManager: UsageStatsManager

    override fun onCreate() {
        super.onCreate()
        usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (!isRunning) {
            startForeground(1, buildNotification())
            isRunning = true
            startMonitoring()
        }
        // Task 4.2 Requirement: START_STICKY
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun startMonitoring() {
        serviceScope.launch {
            var lastEventTime = System.currentTimeMillis()

            while (isActive) {
                val now = System.currentTimeMillis()
                // Task 4.2 Requirement: UsageStatsManager.queryEvents(), NOT queryUsageStats polling
                val events = usageStatsManager.queryEvents(lastEventTime, now)
                val event = UsageEvents.Event()

                while (events.hasNextEvent()) {
                    events.getNextEvent(event)
                    
                    // Task 4.2 Requirement: Detect MOVE_TO_FOREGROUND
                    if (event.eventType == UsageEvents.Event.ACTIVITY_RESUMED) {
                        val packageName = event.packageName
                        if (packageName != null && BlockCacheManager.isPackageBlocked(packageName)) {
                            // Enforce block overlay
                            withContext(Dispatchers.Main) {
                                BlockOverlayManager.showOverlay(applicationContext, packageName)
                            }
                        }
                    }
                }
                lastEventTime = now
                delay(750) // ISSUE-010: Throttled from 200ms to 750ms to reduce battery impact
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        isRunning = false
        serviceScope.cancel()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "focuslock_monitor", "FocusLock Monitor", NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(): Notification {
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, "focuslock_monitor")
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this)
        }
        return builder.setContentTitle("FocusLock Active").setContentText("Monitoring focus sessions.").build()
    }
}
