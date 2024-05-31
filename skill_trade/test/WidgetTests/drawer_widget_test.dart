import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:skill_trade/application/blocs/auth_bloc.dart';
import 'package:skill_trade/presentation/events/auth_event.dart';
import 'package:skill_trade/presentation/widgets/drawer.dart';
import 'drawer_widget_test.mocks.dart';

@GenerateMocks([AuthBloc])
void main() {
  late MockAuthBloc mockAuthBloc;

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text('Home Page')));
        },
      ),
    ],
  );

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.empty());
  });

  // testWidgets('MyDrawer displays correctly and handles logout', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     BlocProvider<AuthBloc>.value(
  //       value: mockAuthBloc,
  //       child: MaterialApp.router(
  //         routerDelegate: router.routerDelegate,
  //         routeInformationParser: router.routeInformationParser,
  //         routeInformationProvider: router.routeInformationProvider,
  //         builder: (context, child) {
  //           return Scaffold(
  //             drawer: const MyDrawer(),
  //             body: child,
  //           );
  //         },
  //       ),
  //     ),
  //   );

  //   // Open the drawer
  //   ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
  //   scaffoldState.openDrawer();
  //   await tester.pumpAndSettle();

  //   // Verify drawer items are displayed
  //   expect(find.byType(DrawerHeader), findsOneWidget);
  //   expect(find.byType(ListTile), findsNWidgets(5)); // Four menu items and one logout item

  //   // Verify icons and text in the ListTile widgets
  //   expect(find.widgetWithIcon(ListTile, Icons.info), findsOneWidget);
  //   expect(find.widgetWithIcon(ListTile, Icons.settings), findsOneWidget);
  //   expect(find.widgetWithIcon(ListTile, Icons.feedback), findsOneWidget);
  //   expect(find.widgetWithIcon(ListTile, Icons.rule), findsOneWidget);
  //   expect(find.widgetWithIcon(ListTile, Icons.logout), findsOneWidget);

  //   expect(find.text('About'), findsOneWidget);
  //   expect(find.text('Settings'), findsOneWidget);
  //   expect(find.text('Feedback'), findsOneWidget);
  //   expect(find.text('Rules and Regulations'), findsOneWidget);
  //   expect(find.text('Logout'), findsOneWidget);

  //   // Tap on the logout button
  //   await tester.tap(find.widgetWithText(ListTile, 'Logout'));
  //   await tester.pumpAndSettle();

  //   // Verify the UnlogEvent is added to the bloc
  //   verify(mockAuthBloc.add(UnlogEvent())).called(1);

  //   // Verify navigation to home page
  //   expect(find.text('Home Page'), findsOneWidget);
  // });
}
