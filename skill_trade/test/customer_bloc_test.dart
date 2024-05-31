import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/domain/repositories/customer_repository.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';

import 'customer_bloc_test.mocks.dart';

@GenerateMocks([CustomerRepository])
void main() {
  late MockCustomerRepository mockCustomerRepository;
  late CustomerBloc customerBloc;

  setUp(() {
    mockCustomerRepository = MockCustomerRepository();
  });

  tearDown(() {
    customerBloc.close();
  });

  group('CustomerBloc', () {
    final customer = Customer(
      fullName: 'name',
      phone: '0987654',
      id: 1,
      email: 'johndoe@example.com',
    );

    final customers = [
     Customer(
      fullName: 'name',
      phone: '0987654',
      id: 1,
      email: 'johndoe@example.com',
    ),
      Customer(
      fullName: 'name',
      phone: '0987654',
      id: 1,
      email: 'johndoe@example.com',
    ),
    ];

    blocTest<CustomerBloc, CustomerState>(
      'emits [CustomerLoading, CustomerLoaded] when LoadCustomer event is added',
      setUp: () {
        when(mockCustomerRepository.fetchCustomer('1')).thenAnswer((_) async => customer);
      },
      build: () {
        customerBloc = CustomerBloc(customerRepository: mockCustomerRepository);
        return customerBloc;
      },
      act: (bloc) => bloc.add(LoadCustomer(customerId: '1')),
      expect: () => [CustomerLoaded(customer: customer)],
    );

    blocTest<CustomerBloc, CustomerState>(
      'emits [CustomerLoading, AllCustomersLoaded] when LoadAllCustomers event is added',
      setUp: () {
        when(mockCustomerRepository.fetchAllCustomers()).thenAnswer((_) async => customers);
      },
      build: () {
        customerBloc = CustomerBloc(customerRepository: mockCustomerRepository);
        return customerBloc;
      },
      act: (bloc) => bloc.add(LoadAllCustomers()),
      expect: () => [AllCustomersLoaded(customers)],
    );

    blocTest<CustomerBloc, CustomerState>(
      'emits [CustomerLoading, CustomerError] when LoadCustomer event is added and an error occurs',
      setUp: () {
        when(mockCustomerRepository.fetchCustomer('1')).thenThrow(Exception('Failed to load customer'));
      },
      build: () {
        customerBloc = CustomerBloc(customerRepository: mockCustomerRepository);
        return customerBloc;
      },
      act: (bloc) => bloc.add(LoadCustomer(customerId: '1')),
      expect: () => [CustomerError('Exception: Failed to load customer')],
    );

    blocTest<CustomerBloc, CustomerState>(
      'emits [CustomerLoading, CustomerError] when LoadAllCustomers event is added and an error occurs',
      setUp: () {
        when(mockCustomerRepository.fetchAllCustomers()).thenThrow(Exception('Failed to load customers'));
      },
      build: () {
        customerBloc = CustomerBloc(customerRepository: mockCustomerRepository);
        return customerBloc;
      },
      act: (bloc) => bloc.add(LoadAllCustomers()),
      expect: () => [CustomerError('Exception: Failed to load customers')],
    );
  });
}
