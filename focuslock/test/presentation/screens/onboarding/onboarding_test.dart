import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/screens/onboarding/onboarding_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }

  group('OnboardingScreen Widget Tests', () {
    testWidgets('Renders welcome screen', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Welcome to FocusLock'), findsOneWidget);
    });

    testWidgets('Can swipe between pages', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();
      // Should now be on Permissions page
    });
  });
}
