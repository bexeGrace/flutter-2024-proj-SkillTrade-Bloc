import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/presentation/widgets/customer_tile.dart';

void main() {
  final Customer testCustomer = Customer(
    id: 1,
    fullName: 'Jane Doe',
    email: 'janedoe@example.com',
    phone: '123-456-7890',
  );

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/admincustomer',
        builder: (context, state) {
          final customer = state.extra as Customer;
          return Scaffold(
            body: Center(
              child: Text('Customer Review: ${customer.fullName}'),
            ),
          );
        },
      ),
    ],
  );

  // testWidgets('CustomerTile displays customer details and navigates on review button press', (WidgetTester tester) async {
  //   // Build the widget
  //   await tester.pumpWidget(
  //     MaterialApp.router(
  //       routerDelegate: router.routerDelegate,
  //       routeInformationParser: router.routeInformationParser,
  //       routeInformationProvider: router.routeInformationProvider,
  //       builder: (context, child) {
  //         return Scaffold(
  //           body: CustomerTile(
  //             customer: testCustomer,
  //           ),
  //         );
  //       },
  //     ),
  //   );

  //   // Wait for the widget to be fully rendered
  //   await tester.pumpAndSettle();

  //   // Verify the customer image is displayed
  //   expect(find.byType(Image), findsOneWidget);

  //   // Verify the customer details are displayed
  //   expect(find.text(testCustomer.fullName), findsOneWidget);
  //   expect(find.text('Email:'), findsOneWidget);
  //   expect(find.text(testCustomer.email), findsOneWidget);
  //   expect(find.text('tel:'), findsOneWidget);
  //   expect(find.text(testCustomer.phone), findsOneWidget);

  //   // Verify the review button is displayed
  //   expect(find.text('Review'), findsOneWidget);

  //   // Tap the review button and verify navigation
  //   await tester.tap(find.text('Review'));
  //   await tester.pumpAndSettle();

  //   // Verify the navigation to the new screen
  //   expect(find.text('Customer Review:'), findsOneWidget);
  //   expect(find.text(testCustomer.fullName), findsOneWidget);
  // });
}
