import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/presentation/widgets/customer_profile.dart';

void main() {
  final Customer testCustomer = Customer(
    id: 1,
    fullName: 'Jane Doe',
    email: 'janedoe@example.com',
    phone: '123-456-7890',
  );

  testWidgets('customerProfile screen displays customer details', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: customerProfile(
            customer: testCustomer,
          ),
        ),
      ),
    );

    // Wait for the widget to be fully rendered
    await tester.pumpAndSettle();

    // Verify the profile image is displayed
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Verify the customer details are displayed
    expect(find.text('Name:'), findsOneWidget);
    expect(find.text(testCustomer.fullName), findsOneWidget);
    expect(find.text('Email:'), findsOneWidget);
    expect(find.text(testCustomer.email), findsOneWidget);
    expect(find.text('Phone:'), findsOneWidget);
    expect(find.text(testCustomer.phone), findsOneWidget);
  });
}
