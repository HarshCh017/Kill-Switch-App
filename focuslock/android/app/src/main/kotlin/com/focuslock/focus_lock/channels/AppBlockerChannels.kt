package com.focuslock.focus_lock.channels

import android.content.Context
import android.content.Intent
import android.os.Build
import com.focuslock.focus_lock.services.AppMonitorForegroundService
import com.focuslock.focus_lock.services.BlockCacheManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AppBlockerChannels(private val context: Context) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    
    companion object {
        const val METHOD_CHANNEL_NAME = "com.focuslock.focus_lock/method"
        const val EVENT_CHANNEL_NAME = "com.focuslock.focus_lock/events"
    }

    private var eventSink: EventChannel.EventSink? = null

    // MethodChannel (Task 4.5)
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startMonitoring" -> {
                val intent = Intent(context, AppMonitorForegroundService::class.java)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    context.startForegroundService(intent)
                } else {
                    context.startService(intent)
                }
                result.success(true)
            }
            "stopMonitoring" -> {
                val intent = Intent(context, AppMonitorForegroundService::class.java)
                context.stopService(intent)
                result.success(true)
            }
            "refreshBlockCache" -> {
                val packages = call.argument<List<String>>("packages")
                if (packages != null) {
                    BlockCacheManager.refreshBlockedPackages(packages)
                    result.success(true)
                } else {
                    result.error("ERR", "Missing packages", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    // EventChannel (Task 4.6)
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    // Call this from the service when a block is enforced
    fun dispatchBlockedAttemptEvent(packageName: String) {
        eventSink?.success(mapOf("event" to "blocked_attempt", "package" to packageName))
    }
}
