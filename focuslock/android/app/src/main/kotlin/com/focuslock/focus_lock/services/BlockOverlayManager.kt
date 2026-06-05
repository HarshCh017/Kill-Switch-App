package com.focuslock.focus_lock.services

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.PixelFormat
import android.os.Build
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView

object BlockOverlayManager {
    private var isOverlayShowing = false
    private var currentOverlayView: View? = null

    // Task 4.3 Requirement: <100ms launch target, Go Home Button, Motivational Quote
    fun showOverlay(context: Context, blockedPackageName: String) {
        if (isOverlayShowing) return
        
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val overlayView = buildProgrammaticView(context)

        val layoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            else
                @Suppress("DEPRECATION") WindowManager.LayoutParams.TYPE_PHONE,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL or
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
            PixelFormat.TRANSLUCENT
        )
        layoutParams.gravity = Gravity.CENTER

        windowManager.addView(overlayView, layoutParams)
        currentOverlayView = overlayView
        isOverlayShowing = true
    }

    private fun buildProgrammaticView(context: Context): View {
        val layout = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setBackgroundColor(Color.parseColor("#1A1A1D")) // Dark minimal theme
        }
        
        val title = TextView(context).apply {
            text = "FocusLock"
            textSize = 32f
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
        }
        
        val quote = TextView(context).apply {
            text = "\"Discipline is choosing between what you want now, and what you want most.\""
            textSize = 18f
            setTextColor(Color.LTGRAY)
            setPadding(32, 64, 32, 64)
            gravity = Gravity.CENTER
        }
        
        val goHomeBtn = Button(context).apply {
            text = "Go to Home" // Required by Task 4.3
            setOnClickListener {
                val homeIntent = Intent(Intent.ACTION_MAIN).apply {
                    addCategory(Intent.CATEGORY_HOME)
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                }
                context.startActivity(homeIntent)
                removeOverlay(context)
            }
        }
        
        layout.addView(title)
        layout.addView(quote)
        layout.addView(goHomeBtn)
        
        return layout
    }

    fun removeOverlay(context: Context) {
        if (!isOverlayShowing) return
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        currentOverlayView?.let { windowManager.removeView(it) }
        currentOverlayView = null
        isOverlayShowing = false
    }
}
