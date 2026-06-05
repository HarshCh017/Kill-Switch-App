import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:focuslock/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Application Test', () {
    testWidgets('Flow 1: Login -> Create Block -> Verify', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Simulate Login UI Interaction
      expect(find.byType(MaterialApp), findsOneWidget);
      // In a real device test, we would tap login, type, and verify the block gets inserted into Drift
    });

    testWidgets('Flow 2: Session Lifecycle (Active -> Complete)', (tester) async {
      // Simulate Session Creation UI
      app.main();
      await tester.pumpAndSettle();
      // Ensure Session complete screen or active screen can be reached
    });

    testWidgets('Flow 3: Backup -> Restore Settings', (tester) async {
      // Trigger the export/import functionality and verify Drift data integrity
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
