import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salam_vietnam/app/app.dart';

void main() {
  testWidgets('Salam Vietnam app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SalamVietnamApp()));
    await tester.pumpAndSettle();

    // Verify that 'Salam Vietnam' title is rendered
    expect(find.text('Salam Vietnam'), findsWidgets);
  });
}
