import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  testWidgets('basic Flutter test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Text('مَدار')));
    expect(find.text('مَدار'), findsOneWidget);
  });
}
