
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_helper/main.dart';

void main() {
  testWidgets('HabitHelper dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(const HabitHelperApp());

    expect(find.text('HabitHelper'), findsOneWidget);
    expect(find.text('Legenda'), findsOneWidget);
    expect(find.text('Nawyki na każdy dzień'), findsOneWidget);
  });
}
