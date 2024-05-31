import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/screens/admin_users_page.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';
import 'package:skill_trade/domain/models/customer.dart';

class MockCustomerBloc extends MockBloc<CustomerEvent, CustomerState>
    implements CustomerBloc {}

void main() {
  late MockCustomerBloc mockCustomerBloc;

  setUp(() {
    mockCustomerBloc = MockCustomerBloc();
  });

  testWidgets('CustomersList widget test', (WidgetTester tester) async {
    // Define a list of customers for testing
    final List<Customer> customers = [
      Customer(
          id: 1,
          fullName: 'John Doe',
          email: 'john.doe@example.com',
          phone: '09398'),
      Customer(
          id: 2,
          fullName: 'Jane Smith',
          email: 'biniyam@gmail.com',
          phone: '1234'),
    ];

    // Stub the bloc's behavior
    when(mockCustomerBloc.state)
        .thenAnswer((_) => AllCustomersLoaded(customers));

    // Pump the widget with the mock bloc
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CustomerBloc>(
          create: (_) => mockCustomerBloc,
          child: CustomersList(),
        ),
      ),
    );

    // Wait for the widget to settle
    await tester.pumpAndSettle();

    // Verify the 'Customers' text is displayed
    expect(find.text('Customers'), findsOneWidget);

    // Verify the email address of the second customer is displayed
    expect(find.text('biniyam@gmail.com'), findsOneWidget);
  });
}
