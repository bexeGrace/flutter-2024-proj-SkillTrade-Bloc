import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/screens/home_page.dart';
import 'package:skill_trade/presentation/widgets/my_button.dart';
import 'package:skill_trade/presentation/widgets/services_card.dart';
import 'package:go_router/go_router.dart';

void main() {
  // testWidgets('HomeScreen displays correctly', (WidgetTester tester) async {
  //   // Define a test GoRouter
  //   final router = GoRouter(
  //     routes: [
  //       GoRoute(
  //         path: '/',
  //         builder: (context, state) => const HomeScreen(),
  //       ),
  //       GoRoute(
  //         path: '/login',
  //         builder: (context, state) => const Scaffold(body: Text('Login Page')),
  //       ),
  //       GoRoute(
  //         path: '/signup',
  //         builder: (context, state) =>
  //             const Scaffold(body: Text('Signup Page')),
  //       ),
  //     ],
  //   );

  //   // Build the HomeScreen widget within the MaterialApp
  //   await tester.pumpWidget(
  //     MaterialApp.router(
  //       routerConfig: router,
  //     ),
  //   );

  //   // Verify if the HomeScreen contains the expected text and widgets
  //   expect(find.text('SkillTrade Hub'), findsOneWidget);
  //   expect(find.text('Welcome to the hub of skills!'), findsOneWidget);
  //   expect(find.text('We Connect!'), findsOneWidget);
  //   expect(find.text('Find Skilled Technicians for Your Home Services'),
  //       findsOneWidget);
  //   expect(
  //       find.text(
  //           'Efficiently connect with experts in plumbing, electrical work, HVAC, and more.'),
  //       findsOneWidget);
  //   expect(find.text('Our Services'), findsOneWidget);

  //   // Verify if the HomeScreen contains the expected buttons
  //   expect(find.widgetWithText(MyButton, 'login'), findsOneWidget);
  //   expect(find.widgetWithText(MyButton, 'signup'), findsOneWidget);

  //   // Verify if the HomeScreen contains the expected service cards
  //   expect(find.byType(ServicesCard), findsNWidgets(4));

  //   // Test button navigation
  //   await tester.tap(find.widgetWithText(MyButton, 'login'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Login Page'), findsOneWidget);

  //   // Go back to HomeScreen
  //   router.go('/');
  //   await tester.pumpAndSettle();
  //   await tester.tap(find.widgetWithText(MyButton, 'signup'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Signup Page'), findsOneWidget);
  // });
}
