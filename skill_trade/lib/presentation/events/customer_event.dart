import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomer extends CustomerEvent {
  final String customerId;

  const LoadCustomer({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

class LoadAllCustomers extends CustomerEvent {
  const LoadAllCustomers();

  @override
  List<Object?> get props => [];
}

class UpdatePassword extends CustomerEvent {
  final int id;
  final String role;
  final String oldPassword;
  final String newPassword;

  const UpdatePassword({
    required this.id,
    required this.role,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
        id,
        role,
        oldPassword,
        newPassword,
      ];
}
