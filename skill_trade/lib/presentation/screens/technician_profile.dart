import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
import 'package:skill_trade/presentation/widgets/info_label.dart';
import 'package:skill_trade/state_managment/individual_technician/individual_technician_bloc.dart';
import 'package:skill_trade/state_managment/individual_technician/individual_technician_event.dart';
import 'package:skill_trade/state_managment/individual_technician/individual_technician_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Technician Profile",
      home: TechnicianProfile(),
    );
  }
}

class TechnicianProfile extends StatefulWidget {
  const TechnicianProfile({Key? key}) : super(key: key);

  @override
  State<TechnicianProfile> createState() => _TechnicianProfileState();
}

class _TechnicianProfileState extends State<TechnicianProfile> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IndividualTechnicianBloc>(context).add(LoadIndividualTechnician(technicianId: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            BlocBuilder<IndividualTechnicianBloc, IndividualTechnicianState>(
              builder: (context, state) {
                if (state is IndividualTechnicianLoaded) {
                  if (_controllers.isEmpty) {
                    _controllers['phone'] = TextEditingController(text: state.technician.phone);
                    _controllers['skills'] = TextEditingController(text: state.technician.skills);
                    _controllers['experience'] = TextEditingController(text: state.technician.experience);
                    _controllers['education_level'] = TextEditingController(text: state.technician.education_level);
                    _controllers['available_location'] = TextEditingController(text: state.technician.available_location);
                    _controllers['additional_bio'] = TextEditingController(text: state.technician.additional_bio);
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/technician.png",
                        width: 125,
                        height: 125,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.technician.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoLabel(label: "Email", data: state.technician.email,),
                            const SizedBox(height: 3),
                            EditableField(label: "Phone", data: state.technician.phone, controller: _controllers['phone'],),
                            const SizedBox(height: 3),
                            EditableField(label: "Skills", data: state.technician.skills, controller: _controllers['skills'],),
                            const SizedBox(height: 3),
                            EditableField(label: "Experience", data: state.technician.experience, controller: _controllers['experience'],),
                            const SizedBox(height: 3),
                            EditableField(label: "Education Level", data: state.technician.education_level, controller: _controllers['education_level'],),
                            const SizedBox(height: 3),
                            EditableField(label: "Available Location", data: state.technician.available_location, controller: _controllers['available_location'],),
                            const SizedBox(height: 3),
                            EditableField(label: "Additional Bio", data: state.technician.additional_bio, controller: _controllers['additional_bio'],),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                onPressed: () => updateProfile(state.technician.id),
                                child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
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
          ],
        ),
      ),
    );
  }

  void updateProfile(technicianId) {
    final updatedData = {
      'phone': _controllers['phone']?.text,
      'skills': _controllers['skills']?.text,
      'experience': _controllers['experience']?.text,
      'education_level': _controllers['education_level']?.text,
      'available_location': _controllers['available_location']?.text,
      'additional_bio': _controllers['additional_bio']?.text,
    };

    BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: technicianId, updates: updatedData));
  }
}
