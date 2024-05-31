import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/widgets/technician_tile.dart';
import 'package:skill_trade/application/blocs/find_technician_bloc.dart';
import 'package:skill_trade/presentation/events/find_technician_event.dart';
import 'package:skill_trade/presentation/states/find_technician_state.dart';

class TechniciansList extends StatelessWidget {
  const TechniciansList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TechniciansBloc>(context).add(LoadTechnicians());
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Technicians",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: BlocBuilder<TechniciansBloc, TechniciansState>(
              builder: (context, state) {
                if (state is TechniciansLoading){
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TechniciansLoaded) {
                  final List<Technician> technicians = state.technicians;
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return TechnicianTile(technician: technicians[index]);
                    },
                  itemCount: technicians.length,
                  );
                } else if (state is TechniciansError) {
                  return Center(child: Text(state.error));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
