import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/presentation/widgets/customer_tile.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';

void main() {
  runApp(const MaterialApp(
    home: CustomersList(),
  ));
}

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CustomerBloc>(context).add(LoadAllCustomers());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Text(
              "Customers",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
          ),
        ),
        Expanded(
          child: BlocBuilder<CustomerBloc, CustomerState>(
                  builder: (context, state) {
                    if (state is CustomerLoading){
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AllCustomersLoaded) {
                      final List<Customer> customers= state.customers;
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return CustomerTile(customer: customers[index]);
                        },
                      itemCount: customers.length,
                      );
                    } else if (state is CustomerError) {
                      return Center(child: Text(state.error));
                    } else {
                      return Container();
                    }
                  },
                ),
        ),
      ],
    );
  }
}
