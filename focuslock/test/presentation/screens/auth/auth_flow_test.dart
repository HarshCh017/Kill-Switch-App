import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/screens/auth/login_screen.dart';
import 'package:focuslock/presentation/screens/auth/registration_screen.dart';
import 'package:focuslock/presentation/screens/auth/forgot_password_screen.dart';

void main() {
  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(home: child);
  }

  group('Authentication Flow Widget Tests', () {
    testWidgets('LoginScreen renders correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(const LoginScreen()));
      expect(find.text('Sign In'), findsWidgets);
      expect(find.text('Email'), findsWidgets);
      expect(find.text('Password'), findsWidgets);
    });

    testWidgets('LoginScreen triggers validation errors on empty submit', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(const LoginScreen()));
      await tester.tap(find.widgetWithText(FilledButton, 'Sign In'));
      await tester.pump();
      expect(find.text('Required'), findsNWidgets(2));
    });

    testWidgets('RegistrationScreen validates matching passwords', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(const RegistrationScreen()));
      
      final textFields = find.byType(TextFormField);
      // Name, Email, Password, Confirm Password
      await tester.enterText(textFields.at(2), 'password123');
      await tester.enterText(textFields.at(3), 'password456');
      
      await tester.tap(find.widgetWithText(FilledButton, 'Register'));
      await tester.pump();
      
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('ForgotPasswordScreen renders correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(const ForgotPasswordScreen()));
      expect(find.text('Send Reset Link'), findsOneWidget);
    });
  });
}
