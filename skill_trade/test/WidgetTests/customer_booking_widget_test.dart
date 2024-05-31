import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/presentation/states/bookings_state.dart';
import 'package:skill_trade/presentation/widgets/customer_booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';

class MockBookingsBloc extends MockBloc<BookingsEvent, BookingsState> implements BookingsBloc {}

void main() {
  final Booking testBooking = Booking(
    id: 1,
    customerId: 1,
    technicianId: 1,
    serviceNeeded: 'Plumbing',
    problemDescription: 'Leaking pipe in the kitchen',
    serviceLocation: '123 Main St',
    serviceDate: DateTime.now(),
    bookedDate: DateTime.now().subtract(Duration(days: 1)),
    status: 'Pending',
  );

  final Technician testTechnician = Technician(
    id: 1,
    name: 'John Doe',
    email: 'johndoe@example.com',
    skills: 'Plumber',
    phone: '123-456-7890',
    experience: '1',
    education_level: 'nepa',
    available_location: 'addis',
    additional_bio: 'none',
    status: 'pending'
  );

  const String testCustomerId = '1';

  // testWidgets('CustomerBooking screen displays booking details and handles interactions', (WidgetTester tester) async {
  //   // Create the widget by telling the tester to build it.
  //   await tester.pumpWidget(
  //     BlocProvider<BookingsBloc>(
  //       create: (context) => MockBookingsBloc(),
  //       child: MaterialApp(
  //         home: Scaffold(
  //           body: CustomerBooking(
  //             booking: testBooking,
  //             technician: testTechnician,
  //             customerId: testCustomerId,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  //   // Wait for the widget to be fully rendered.
  //   await tester.pumpAndSettle();

  //   // Verify the booking details are displayed.
  //   expect(find.text('Booked With'), findsOneWidget);
  //   expect(find.text(testTechnician.name), findsOneWidget);
  //   expect(find.text(testTechnician.email), findsOneWidget);
  //   expect(find.text(testTechnician.skills), findsOneWidget);
  //   expect(find.text(testTechnician.phone), findsOneWidget);
  //   expect(find.text('Service Needed'), findsOneWidget);
  //   expect(find.text(testBooking.serviceNeeded), findsOneWidget);
  //   expect(find.text('Problem Description'), findsOneWidget);
  //   expect(find.text(testBooking.problemDescription), findsOneWidget);
  //   expect(find.text('Service Location'), findsOneWidget);
  //   expect(find.text(testBooking.serviceLocation), findsOneWidget);
  //   expect(find.text('Status:'), findsOneWidget);
  //   expect(find.text(testBooking.status), findsOneWidget);

  //   // Verify the buttons are displayed.
  //   expect(find.text('Edit'), findsOneWidget);
  //   expect(find.text('Delete Booking'), findsOneWidget);

  //   // Verify the Change Date button is displayed.
  //   expect(find.text('Change Date'), findsOneWidget);

  //   // Tap the 'Edit' button and verify the interaction.
  //   await tester.tap(find.text('Edit'));
  //   await tester.pump();

  //   // Verify the 'Edit' button has been tapped. (Here we should see some behavior if it was real)

  //   // Tap the 'Delete Booking' button and verify the interaction.
  //   await tester.tap(find.text('Delete Booking'));
  //   await tester.pump();

  //   // Verify the 'Delete Booking' button has been tapped. (Here we should see some behavior if it was real)

  //   // Tap the 'Change Date' button and simulate date picker interaction.
  //   await tester.tap(find.text('Change Date'));
  //   await tester.pump();

  //   // Since we cannot actually open the date picker in a test environment, we can skip this part.
  //   // However, you can check if the `_selectDate` method has been called.
  // });
}
