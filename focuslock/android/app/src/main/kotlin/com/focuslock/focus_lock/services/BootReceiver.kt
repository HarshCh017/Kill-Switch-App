package com.focuslock.focus_lock.services

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            val serviceIntent = Intent(context, AppMonitorForegroundService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
            // Trigger ServiceWatchdog WorkManager here
            val workRequest = androidx.work.PeriodicWorkRequestBuilder<ServiceWatchdog>(15, java.util.concurrent.TimeUnit.MINUTES).build()
            androidx.work.WorkManager.getInstance(context).enqueueUniquePeriodicWork(
                "ServiceWatchdog",
                androidx.work.ExistingPeriodicWorkPolicy.KEEP,
                workRequest
            )
        }
    }
}
