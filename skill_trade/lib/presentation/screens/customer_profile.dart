import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/presentation/widgets/customer_profile.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  Future<void> loadId(context) async {
    String? id = await SecureStorage.instance.read("id");
    BlocProvider.of<CustomerBloc>(context).add(LoadCustomer(customerId: id!));
  }

  bool changePassword = false;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loadId(context);
    return BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerLoaded) {
            return ListView(
              children: [
                customerProfile(customer: state.customer,),
                const SizedBox(height: 35,),
                changePassword? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextField(
                       controller: oldPasswordController,
                       decoration: const InputDecoration(
                          hintText: 'Enter old password',
                          border: OutlineInputBorder(),
                        ), 
                        obscureText: true,
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                       controller: newPasswordController,
                       decoration: const InputDecoration(
                          hintText: 'Enter new password',
                          border: OutlineInputBorder(),
                        ), 
                        obscureText: true,
                      ),
                    ],
                  ),
                ): const SizedBox(),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (changePassword && oldPasswordController.text != "" && newPasswordController.text != "") {
                          updatePassword(state.customer.id);
                        }
                        changePassword = !changePassword;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(changePassword? "Save Changes": "Change Password", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            );
          } else if (state is CustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerError) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        }
      );
  }
  
  void updatePassword(id) {
    BlocProvider.of<CustomerBloc>(context).add(UpdatePassword(id: id, role: 'customer', oldPassword: oldPasswordController.text, newPassword: newPasswordController.text));
    oldPasswordController.clear();
    newPasswordController.clear();
  }
}
