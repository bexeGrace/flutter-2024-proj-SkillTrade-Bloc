import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/presentation/widgets/technician_booking_card.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/presentation/states/bookings_state.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:http/http.dart' as http;

class TechnicianBookingList extends StatelessWidget {
  
  TechnicianBookingList({super.key});
  String? id;
  Future<void> loadId(context) async {
    String? id = await SecureStorage.instance.read("id");
    BlocProvider.of<BookingsBloc>(context).add(LoadTechnicianBookings(technicianId: id!));
  }

  @override
  Widget build(BuildContext context) {
    loadId(context);
    return BlocBuilder<BookingsBloc, BookingsState>(
        builder: (context, state) {
          if (state is BookingsLoading){
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingsLoaded) {
            final List<Booking> bookings = state.bookings.reversed.toList();
            return Column(
                children: [
                    Container(
                      color: Theme.of(context).colorScheme.background,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(5),
                      child: const Text(
                        "Booked To You...",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(             
                      scrollDirection: Axis.vertical,
                      itemCount: state.bookings.length,
                      
                      itemBuilder: (context, index) { 
                        return  MultiBlocProvider(
                          providers: [
                            BlocProvider<CustomerBloc>(
                              create: (BuildContext context) => CustomerBloc(customerRepository: CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: CustomerRemoteDataSourceImpl(client: http.Client()))),
                            ),
                          ],
                          child: BlocBuilder<CustomerBloc, CustomerState>(
                          builder: (context, state) {
                            BlocProvider.of<CustomerBloc>(context).add(LoadCustomer(customerId: bookings[index].customerId.toString()));
                            if (state is CustomerLoaded) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TechnicianBookingCard(booking: bookings[index], editAccess: true, customer: state.customer, technicianId: bookings[index].technicianId.toString(),),
                              );
                            } else if (state is CustomerLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is CustomerError) {
                              return Center(child: Text(state.error));
                            } else {
                              return Container();
                            }
                          }
                        )
                        );
                      },
                    ),
                  ),
                ],
              );
          } else if (state is BookingsError) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        }
      );
  }
}
