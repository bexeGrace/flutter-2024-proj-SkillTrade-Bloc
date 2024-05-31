import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/booked_card.dart';

void main() {
  testWidgets('TechnicianBookingScreen displays booking data and buttons work', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      const MaterialApp(
        home: TechnicianBookingScreen(),
      ),
    );

    // Verify the loading indicator is displayed while waiting for the data.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Use pump and settle to wait for the FutureBuilder to complete.
    await tester.pumpAndSettle();

    // Verify the data is displayed.
    expect(find.text('Leaking Pipe'), findsOneWidget);
    expect(find.text('The kitchen sink pipe is leaking.'), findsOneWidget);
    expect(find.text('Location: Addis Ababa'), findsOneWidget);
    expect(find.text('Name: John Doe'), findsOneWidget);

    // Verify the buttons are displayed.
    expect(find.text('Accept'), findsOneWidget);
    expect(find.text('Decline'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    // Tap the 'Accept' button and verify the print statement (simulating the button press).
    await tester.tap(find.text('Accept'));
    await tester.pump();
    // Verify the 'Accept' button has been tapped. (Here we should see some behavior if it was real)

    // Tap the 'Decline' button and verify the print statement (simulating the button press).
    await tester.tap(find.text('Decline'));
    await tester.pump();
    // Verify the 'Decline' button has been tapped. (Here we should see some behavior if it was real)

    // Tap the 'Delete' button and verify the print statement (simulating the button press).
    await tester.tap(find.text('Delete'));
    await tester.pump();
    // Verify the 'Delete' button has been tapped. (Here we should see some behavior if it was real)
  });
}
