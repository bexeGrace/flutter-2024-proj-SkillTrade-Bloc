import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_trade/presentation/screens/home_page.dart';
import 'package:skill_trade/presentation/widgets/services_card.dart';

// Mock implementation of MyButton
class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

void main() {
  // testWidgets('HomeScreen displays correctly and handles button taps',
  //     (WidgetTester tester) async {
  //   // Create a mock GoRouter
  //   final goRouter = GoRouter(
  //     routes: [
  //       GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  //       GoRoute(
  //           path: '/login',
  //           builder: (context, state) =>
  //               const Scaffold(body: Text('Login Screen'))),
  //       GoRoute(
  //           path: '/signup',
  //           builder: (context, state) =>
  //               const Scaffold(body: Text('Signup Screen'))),
  //     ],
  //   );

  //   // Build the HomeScreen widget
  //   await tester.pumpWidget(
  //     MaterialApp.router(
  //       routerDelegate: goRouter.routerDelegate,
  //       routeInformationParser: goRouter.routeInformationParser,
  //     ),
  //   );

  //   // Verify initial state
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

  //   // Verify the presence of service cards
  //   expect(find.byType(ServicesCard), findsNWidgets(4));

  //   // Tap on the login button and verify navigation
  //   await tester.tap(find.text('login'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Login Screen'), findsOneWidget);

  //   // Navigate back to HomeScreen
  //   goRouter.go('/');
  //   await tester.pumpAndSettle();

  //   // Tap on the signup button and verify navigation
  //   await tester.tap(find.text('signup'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Signup Screen'), findsOneWidget);
  // });
}
