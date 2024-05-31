import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/repositories/customer_repository.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository;

  CustomerBloc({required this.customerRepository}) : super(CustomerLoading()) {
    on<LoadCustomer>(_onLoadCustomer);
    on<LoadAllCustomers>(_onLoadAllCustomers);
    on<UpdatePassword>(_onUpdatePassword);
  }

  Future<void> _onLoadCustomer(LoadCustomer event, Emitter<CustomerState> emit) async {
    try {
      final customer = await customerRepository.fetchCustomer(event.customerId);
      emit(CustomerLoaded(customer: customer));
    } catch (error) {
      emit(CustomerError(error.toString()));
    }
  }

  Future<void> _onLoadAllCustomers(LoadAllCustomers event, Emitter<CustomerState> emit) async {
    try {
      final customers = await customerRepository.fetchAllCustomers();
      emit(AllCustomersLoaded(customers));
    } catch (error) {
      emit(CustomerError(error.toString()));
    }
  }

  Future<void> _onUpdatePassword(UpdatePassword event, Emitter<CustomerState> emit) async {
    try {
      await customerRepository.updatePassword(
        {
          "role": event.role,
          "id": event.id,
          "newPassword": event.newPassword,
          "password": event.oldPassword
        }
      );
    } catch (error) {
      emit(CustomerError(error.toString()));
    }
  }
}
