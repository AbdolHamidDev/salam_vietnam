import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salam_vietnam/app/app.dart';
import 'package:salam_vietnam/core/localization/locale_provider.dart';

void main() {
  group('Localization Tests', () {
    testWidgets('App renders correctly in Vietnamese (vi)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: SalamVietnamApp()));
      await tester.pumpAndSettle();

      expect(find.text('Salam Vietnam'), findsWidgets);
      expect(find.text('Khám phá'), findsWidgets);
    });

    testWidgets('App renders correctly when switching to English (en)', (
      WidgetTester tester,
    ) async {
      final container = ProviderContainer();
      container.read(localeProvider.notifier).setLanguageCode('en');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SalamVietnamApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Explore'), findsWidgets);
      expect(find.text('Map'), findsWidgets);
    });

    testWidgets('App renders correctly when switching to Malay (ms)', (
      WidgetTester tester,
    ) async {
      final container = ProviderContainer();
      container.read(localeProvider.notifier).setLanguageCode('ms');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const SalamVietnamApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Jelajah'), findsWidgets);
      expect(find.text('Peta'), findsWidgets);
    });
  });
}
