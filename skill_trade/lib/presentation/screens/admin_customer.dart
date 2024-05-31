import 'package:flutter/material.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/presentation/widgets/customer_profile.dart';

class AdminCustomer extends StatelessWidget {
  final Customer customer;
  const AdminCustomer({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer"),
        centerTitle: true,
      ),
      body: customerProfile(customer: customer),
      );
    // );
  }
}
