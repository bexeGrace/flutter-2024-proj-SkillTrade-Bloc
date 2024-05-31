import 'package:skill_trade/domain/models/customer.dart';

abstract class CustomerRepository {
  Future<Customer> fetchCustomer(String customerId);
  Future<List<Customer>> fetchAllCustomers();
  Future<void> updatePassword(Map<String, dynamic> updates);
}
