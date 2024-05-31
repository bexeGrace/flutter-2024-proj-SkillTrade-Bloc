import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/info_label.dart';

void main() {
  testWidgets('InfoLabel displays label and data correctly', (WidgetTester tester) async {
    const String testLabel = 'Test Label';
    const String testData = 'Test Data';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InfoLabel(
            label: testLabel,
            data: testData,
          ),
        ),
      ),
    );

    // Verify that the label is displayed correctly
    expect(find.text('$testLabel:'), findsOneWidget);

    // Verify that the data is displayed correctly
    expect(find.text(testData), findsOneWidget);

    // Verify that the Row contains both the label and the data
    final rowFinder = find.byType(Row);
    expect(rowFinder, findsOneWidget);

    final rowWidget = tester.widget<Row>(rowFinder);
    expect(rowWidget.children.length, 3);

    final textWidgets = rowWidget.children.whereType().toList();
    expect(textWidgets[0].data, '$testLabel:');
    expect(textWidgets[1], isA<SizedBox>());
    expect(textWidgets[2].data, testData);

  });
}
