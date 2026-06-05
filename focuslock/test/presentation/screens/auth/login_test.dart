import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/screens/auth/login_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('Renders input fields and login button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Renders Google Sign In button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Sign in with Google'), findsOneWidget);
    });

    testWidgets('Empty submission shows validation errors', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter an email'), findsOneWidget);
    });
  });
}
