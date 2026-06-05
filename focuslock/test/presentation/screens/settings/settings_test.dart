import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/screens/settings/settings_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: SettingsScreen(),
    );
  }

  group('SettingsScreen Widget Tests', () {
    testWidgets('Displays Profile Header', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('User Name'), findsOneWidget);
    });

    testWidgets('Displays System Health Score', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('System Health'), findsOneWidget);
      expect(find.text('92%'), findsOneWidget);
    });

    testWidgets('Displays Permissions Dashboard', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Usage Access'), findsOneWidget);
      expect(find.text('Overlay Permissions'), findsOneWidget);
    });

    testWidgets('Toggles Preferences successfully', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final switchFinder = find.byType(Switch).first;
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
    });
  });
}
