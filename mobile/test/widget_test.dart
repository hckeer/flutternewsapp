import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/app.dart';

void main() {
  testWidgets('App boots to splash', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DengueNepalApp()));
    expect(find.text('Dengue Nepal'), findsOneWidget);
  });
}
