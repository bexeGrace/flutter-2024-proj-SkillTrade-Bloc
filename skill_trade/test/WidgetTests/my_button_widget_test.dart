import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/my_button.dart';

void main() {
  testWidgets('MyButton displays text and handles onPressed correctly', (WidgetTester tester) async {
    const String buttonText = 'Test Button';
    bool wasPressed = false;

    // Define the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            text: buttonText,
            onPressed: () {
              wasPressed = true;
            },
            width: 150.0,
          ),
        ),
      ),
    );

    // Verify that the button text is displayed correctly
    expect(find.text(buttonText), findsOneWidget);

    // Verify that the button is rendered with the correct width
    final containerFinder = find.byType(Container);
    final containerRenderBox = tester.renderObject<RenderBox>(containerFinder);
    expect(containerRenderBox.size.width, 150.0);

    // Verify that the onPressed callback is triggered when the button is tapped
    expect(wasPressed, isFalse);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(wasPressed, isTrue);
  });
}
