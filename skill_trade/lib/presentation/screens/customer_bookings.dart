import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/presentation/widgets/customer_booking.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/presentation/states/bookings_state.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';

class CustomerBookings extends StatelessWidget {
  CustomerBookings({super.key});
  String? id;
  Future<void> loadId(context) async {
    String? id = await SecureStorage.instance.read("id");
    BlocProvider.of<BookingsBloc>(context).add(LoadCustomerBookings(customerId: id!));
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
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) { 
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<IndividualTechnicianBloc>(
                      create: (BuildContext context) => IndividualTechnicianBloc(individualTechnicianRepository: IndividualTechnicianRepository(remoteDataSource: IndividualTechnicianRemoteDataSource())),
                    ),
                  ],
                  child: BlocBuilder<IndividualTechnicianBloc, IndividualTechnicianState>(
                  builder: (context, state) {
                    BlocProvider.of<IndividualTechnicianBloc>(context).add(LoadIndividualTechnician(technicianId: bookings[index].technicianId));
                    if (state is IndividualTechnicianLoaded){
                      return CustomerBooking(
                        technician: state.technician,
                        booking: bookings[index],
                        customerId: bookings[index].customerId.toString(),
                      );
                    } else if (state is IndividualTechnicianLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is IndividualTechnicianError) {
                      return Center(child: Text(state.error));
                    } else {
                      return Container();
                    }
                  }
                  ),
                );
                // }
                
              },
              itemCount: bookings.length,
            );
          } else if (state is BookingsError) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      );
  }
}
