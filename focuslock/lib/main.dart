import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/firebase_service.dart';
import 'core/services/crashlytics_logger.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/navigation/main_nav_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as flutter_secure_storage;
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'core/constants/app_constants.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    await FirebaseService.initialize();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      CrashlyticsLogger.log('FlutterError: ${details.exceptionAsString()}');
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Material(
        child: Container(
          color: Colors.redAccent,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error_outline, color: Colors.white, size: 48),
              SizedBox(height: 16),
              Text(
                'Something went wrong.',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'We have logged the issue and are looking into it.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    };

    runApp(
      const ProviderScope(
        child: FocusLockApp(),
      ),
    );
  }, (error, stack) {
    CrashlyticsLogger.log('Zoned Error: $error');
  });
}

class FocusLockApp extends StatelessWidget {
  const FocusLockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusLock',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppRouter(),
    );
  }
}

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  bool _isAuthenticated = false;
  bool _hasSeenOnboarding = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    const storage = flutter_secure_storage.FlutterSecureStorage();
    final seen = await storage.read(key: AppConstants.kSharedPrefsOnboardingKey);
    final auth = firebase.FirebaseAuth.instance.currentUser != null;

    if (mounted) {
      setState(() {
        _hasSeenOnboarding = seen == 'true';
        _isAuthenticated = auth;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_hasSeenOnboarding && !_isAuthenticated) {
      return const OnboardingScreen();
    } else if (!_isAuthenticated) {
      return const LoginScreen();
    } else {
      return const MainNavScreen();
    }
  }
}
