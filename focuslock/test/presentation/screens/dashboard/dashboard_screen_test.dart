import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/presentation/dashboard/dashboard_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: DashboardScreen(),
    );
  }

  group('DashboardScreen Widget Tests', () {
    testWidgets('Dashboard renders Active Protection Card', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Protection ON'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Toggling Protection Card updates state', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      final switchFinder = find.byType(Switch);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
      
      expect(find.text('Protection OFF'), findsOneWidget);
    });

    testWidgets('Dashboard renders Metrics row', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Focus Time'), findsOneWidget);
      expect(find.text('Blocks'), findsOneWidget);
      expect(find.text('Streak'), findsOneWidget);
    });
  });
}
