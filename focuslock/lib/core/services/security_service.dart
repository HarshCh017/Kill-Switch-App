// Mocks for scaffolding
class MockFlutterSecureStorage {
  final Map<String, String> _storage = {};
  Future<void> write({required String key, required String value}) async => _storage[key] = value;
  Future<String?> read({required String key}) async => _storage[key];
  Future<void> delete({required String key}) async => _storage.remove(key);
}

class SecurityService {
  final MockFlutterSecureStorage _storage;

  static const String _pinKey = 'strict_mode_pin';
  static const String _emergencyUnlockCountKey = 'emergency_unlock_count';
  static const String _emergencyUnlockResetDateKey = 'emergency_reset_date';

  SecurityService(this._storage);

  /// Sets the strict mode PIN securely.
  Future<void> setStrictModePin(String pin) async {
    // In production, hash the PIN before storing
    await _storage.write(key: _pinKey, value: pin);
  }

  /// Verifies the provided PIN.
  Future<bool> verifyPin(String pin) async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin == pin;
  }

  /// Removes strict mode if PIN is correct.
  Future<bool> disableStrictMode(String pin) async {
    if (await verifyPin(pin)) {
      await _storage.delete(key: _pinKey);
      return true;
    }
    return false;
  }

  /// Emergency Unlock functionality (Task 5.4)
  Future<bool> requestEmergencyUnlock() async {
    await _resetEmergencyCounterIfWeeklyElapsed();

    final countStr = await _storage.read(key: _emergencyUnlockCountKey);
    final count = countStr != null ? int.parse(countStr) : 0;

    // Allow 1 emergency unlock per week
    if (count < 1) {
      await _storage.write(key: _emergencyUnlockCountKey, value: (count + 1).toString());
      await _storage.delete(key: _pinKey); // Temporarily break strict mode
      return true;
    }

    return false; // Deny emergency unlock, weekly quota exceeded
  }

  Future<void> _resetEmergencyCounterIfWeeklyElapsed() async {
    final dateStr = await _storage.read(key: _emergencyUnlockResetDateKey);
    final now = DateTime.now();

    if (dateStr == null) {
      await _storage.write(key: _emergencyUnlockResetDateKey, value: now.toIso8601String());
      return;
    }

    final lastReset = DateTime.parse(dateStr);
    if (now.difference(lastReset).inDays >= 7) {
      await _storage.write(key: _emergencyUnlockCountKey, value: '0');
      await _storage.write(key: _emergencyUnlockResetDateKey, value: now.toIso8601String());
    }
  }
}
