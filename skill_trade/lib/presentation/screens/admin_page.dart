import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/widgets/technician_tile.dart';
import 'package:skill_trade/application/blocs/find_technician_bloc.dart';
import 'package:skill_trade/presentation/events/find_technician_event.dart';
import 'package:skill_trade/presentation/states/find_technician_state.dart';

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TechniciansBloc>(context).add(LoadPendingTechnicians());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Text(
              "Technician Applications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
          ),
        ),
        Expanded(
          child: BlocBuilder<TechniciansBloc, TechniciansState>(
            builder: (context, state) {
              if (state is TechniciansLoading){
                return const Center(child: CircularProgressIndicator());
              } else if (state is PendingTechniciansLoaded) {
                final List<Technician> technicians = state.technicians;
                return technicians.isNotEmpty? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TechnicianTile(technician: technicians[index]);
                  },
                itemCount: technicians.length,
                ): const Center(child: Text("No pending applications"),);
              } else if (state is TechniciansError) {
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
