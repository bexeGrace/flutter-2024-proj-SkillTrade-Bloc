abstract class CustomerEvent {}

class LoadCustomer extends CustomerEvent {
  final String customerId;

  LoadCustomer({required this.customerId});
}

class LoadAllCustomers extends CustomerEvent {}

class UpdatePassword extends CustomerEvent {
  final int id;
  final String role;
  final String oldPassword;
  final String newPassword;

  UpdatePassword({required this.id, required this.role, required this.oldPassword, required this.newPassword});
}