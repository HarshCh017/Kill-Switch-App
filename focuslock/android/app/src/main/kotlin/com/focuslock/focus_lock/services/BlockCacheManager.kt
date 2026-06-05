package com.focuslock.focus_lock.services

import java.util.Collections

object BlockCacheManager {
    // Thread-safe O(1) Set<String> lookup as required by v6.1 Task 4.1
    private val blockedPackages = Collections.synchronizedSet(mutableSetOf<String>())

    fun refreshBlockedPackages(packages: List<String>) {
        blockedPackages.clear()
        blockedPackages.addAll(packages)
    }

    fun isPackageBlocked(packageName: String): Boolean {
        return blockedPackages.contains(packageName)
    }
}
