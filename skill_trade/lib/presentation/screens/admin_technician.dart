import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/presentation/widgets/rating_stars.dart';
import 'package:skill_trade/presentation/widgets/technician_profile.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/states/review_state.dart';

class AdminTechnician extends StatelessWidget {
  final int technicianId;

  const AdminTechnician({super.key, required this.technicianId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IndividualTechnicianBloc>(context).add(LoadIndividualTechnician(technicianId: technicianId));
    BlocProvider.of<ReviewsBloc>(context).add(LoadTechnicianReviews(technicianId: technicianId));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Technician"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          BlocBuilder<IndividualTechnicianBloc, IndividualTechnicianState>(
              builder: (context, state) {
                if (state is IndividualTechnicianLoaded) {
                  return Column(
                    children: [
                      TechnicianSmallProfile(technician: state.technician,),
                      SizedBox(height: 30,),
                      state.technician.status == "suspended" || state.technician.status == "accepted" ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: state.technician.id, updates: {"status": "suspended"}));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            child: const Text(
                              "Suspend",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: state.technician.id, updates: {"status": "accepted"}));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            child: const Text(
                              "Unsuspend",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: state.technician.id, updates: {"status": "accepted"}));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            child: const Text(
                              "Accept application",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: state.technician.id, updates: {"status": "declined"}));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            child: const Text(
                              "Decline application",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ), 
                    ],
                  );
                } else if (state is IndividualTechnicianLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is IndividualTechnicianError) {
                  return Center(child: Text(state.error));
                } else {
                  return Container();
                }
              },
          ),
          const SizedBox(
            height: 30,
          ),

          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: BlocBuilder<ReviewsBloc, ReviewsState>(
              builder: (context, state) {
                if (state is ReviewsLoaded) {
                  return state.reviews.isNotEmpty ? Container(
                    height: state.reviews.length * 110,
                    child: ListView.builder(
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/profile.jpg",
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.reviews[index].customer,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            ListTile(
                              title: RatingStars(
                                  rating: state.reviews[index].rating),
                              subtitle: Text(state.reviews[index].comment)
                              )
                          ],
                        );
                      },
                    ),
                  )
                  :const Text(
                    "No reviews yet!",
                  );
                  } else if (state is ReviewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReviewsError) {
                    return Center(child: Text(state.error));
                  } else {
                    return Container();
                  }
              }
            ),
          ),

          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
