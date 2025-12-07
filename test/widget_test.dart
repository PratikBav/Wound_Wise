import 'package:flutter_test/flutter_test.dart';
import 'package:wound_wise/main.dart';

void main() {
  testWidgets('WoundWise app displays splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WoundWiseApp());

    // Verify that splash screen is displayed
    expect(find.text('Intelligent Wound Assessment'), findsOneWidget);
    
    // Wait for splash screen timer to complete and navigate to home
    await tester.pumpAndSettle(const Duration(seconds: 4));
    
    // Verify that home screen is now displayed
    expect(find.text('WoundWise'), findsOneWidget);
    expect(find.text('Wound Assessment'), findsOneWidget);
  });
}
