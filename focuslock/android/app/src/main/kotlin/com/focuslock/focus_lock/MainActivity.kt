package com.focuslock.focus_lock

import androidx.annotation.NonNull
import com.focuslock.focus_lock.channels.AppBlockerChannels
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        val channels = AppBlockerChannels(context)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AppBlockerChannels.METHOD_CHANNEL_NAME)
            .setMethodCallHandler(channels)
            
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, AppBlockerChannels.EVENT_CHANNEL_NAME)
            .setStreamHandler(channels)

        // Trigger ServiceWatchdog WorkManager
        val workRequest = androidx.work.PeriodicWorkRequestBuilder<com.focuslock.focus_lock.services.ServiceWatchdog>(15, java.util.concurrent.TimeUnit.MINUTES).build()
        androidx.work.WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            "ServiceWatchdog",
            androidx.work.ExistingPeriodicWorkPolicy.KEEP,
            workRequest
        )
    }
}
