import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/screens/admin_page.dart';
import 'package:skill_trade/presentation/screens/reported_technicians.dart';
import 'package:skill_trade/presentation/screens/admin_customer.dart';
import 'package:skill_trade/presentation/screens/technicians_list.dart';

void main() {
  // group('AdminSiteLogic Unit Tests', () {
  //   testWidgets('Initial current index is 0', (WidgetTester tester) async {
  //     final logic = AdminSiteLogic();
  //     expect(logic.currentIndex, 0);
  //   });

  //   testWidgets('onItemTapped sets current index correctly', (WidgetTester tester) async {
  //     final logic = AdminSiteLogic();

  //     // Build a widget to obtain a BuildContext
  //     await tester.pumpWidget(MaterialApp(
  //       home: Builder(
  //         builder: (BuildContext context) {
  //           return Container();
  //         },
  //       ),
  //     ));

  //     final BuildContext context = tester.element(find.byType(Container));

  //     // Simulate navigation to index 1
  //     logic.onItemTapped(context, 1);
  //     expect(logic.currentIndex, 1);

  //     // Simulate navigation to index 2
  //     logic.onItemTapped(context, 2);
  //     expect(logic.currentIndex, 2);
  //   });

  // //   testWidgets('Correct page is returned for each current index', (WidgetTester tester) async {
  // //     final logic = AdminSiteLogic();

  // //     // Build a widget to obtain a BuildContext
  // //     await tester.pumpWidget(MaterialApp(
  // //       home: Builder(
  // //         builder: (BuildContext context) {
  // //           return Container();
  // //         },
  // //       ),
  // //     ));

  // //     final BuildContext context = tester.element(find.byType(Container));

  // //     logic.onItemTapped(context, 0);
  // //     var currentPage = logic.getCurrentPage();
  // //     expect(currentPage, isA<MultiBlocProvider>());

  // //     logic.onItemTapped(context, 1);
  // //     currentPage = logic.getCurrentPage();
  // //     expect(currentPage, isA<MultiBlocProvider>());

  // //     logic.onItemTapped(context, 2);
  // //     currentPage = logic.getCurrentPage();
  // //     expect(currentPage, isA<MultiBlocProvider>());

  // //     logic.onItemTapped(context, 3);
  // //     currentPage = logic.getCurrentPage();
  // //     expect(currentPage, isA<MultiBlocProvider>());
  // //   });
  // // });
}
