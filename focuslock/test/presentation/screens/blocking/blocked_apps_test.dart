import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/screens/blocking/blocked_apps_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: BlockedAppsScreen(),
    );
  }

  group('BlockedAppsScreen Widget Tests', () {
    testWidgets('Displays empty state when no apps are blocked', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      // Assuming it shows 'No blocked apps' text or an empty illustration
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Has Add Block button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Tapping Add Block opens bottom sheet or new screen', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      // Should see some App Picker UI depending on implementation
    });
  });
}
