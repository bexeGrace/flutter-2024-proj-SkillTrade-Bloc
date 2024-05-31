import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/screens/admin.dart';
import 'package:skill_trade/presentation/screens/admin_page.dart';
import 'package:skill_trade/presentation/screens/admin_users_page.dart';
import 'package:skill_trade/presentation/screens/reported_technicians.dart';
import 'package:skill_trade/presentation/screens/technicians_list.dart';
import 'package:skill_trade/presentation/themes.dart';

void main() {
  // testWidgets('AdminSite widget test', (WidgetTester tester) async {
  //   // Build the widget
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       theme: lightMode,
  //       home: const AdminSite(),
  //     ),
  //   );

  //   // Verify the initial state - should display the first page (AdminPage)
  //   expect(find.byType(AdminPage), findsOneWidget);
  //   expect(find.byType(ReportedTechnicians), findsNothing);
  //   expect(find.byType(CustomersList), findsNothing);
  //   expect(find.byType(TechniciansList), findsNothing);

  //   // Tap on the 'Reports' tab and verify
  //   await tester.tap(find.byIcon(Icons.warning));
  //   await tester.pumpAndSettle();
  //   expect(find.byType(AdminPage), findsNothing);
  //   expect(find.byType(ReportedTechnicians), findsOneWidget);
  //   expect(find.byType(CustomersList), findsNothing);
  //   expect(find.byType(TechniciansList), findsNothing);

  //   // Tap on the 'Customers' tab and verify
  //   await tester.tap(find.byIcon(Icons.person));
  //   await tester.pumpAndSettle();
  //   expect(find.byType(AdminPage), findsNothing);
  //   expect(find.byType(ReportedTechnicians), findsNothing);
  //   expect(find.byType(CustomersList), findsOneWidget);
  //   expect(find.byType(TechniciansList), findsNothing);

  //   // Tap on the 'Technicians' tab and verify
  //   await tester.tap(find.byIcon(Icons.person_search));
  //   await tester.pumpAndSettle();
  //   expect(find.byType(AdminPage), findsNothing);
  //   expect(find.byType(ReportedTechnicians), findsNothing);
  //   expect(find.byType(CustomersList), findsNothing);
  //   expect(find.byType(TechniciansList), findsOneWidget);
  // });
}
