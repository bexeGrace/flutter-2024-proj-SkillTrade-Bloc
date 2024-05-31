import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
import 'package:skill_trade/presentation/widgets/info_label.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';

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

  bool changePassword = false;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoadTechnician();
  }

  Future<void> LoadTechnician() async {
    BlocProvider.of<IndividualTechnicianBloc>(context).add(LoadIndividualTechnician(technicianId: int.tryParse((await SecureStorage.instance.read("id"))!)));
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
                                onPressed: () => updateProfile(state.technician),
                                child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            changePassword? Center(
                              child: SizedBox(
                              width: 250,
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
                                                        ),
                            ): const SizedBox(),
                          const SizedBox(height: 15,),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (changePassword && oldPasswordController.text != "" && newPasswordController.text != "") {
                                    updatePassword(state.technician.id);
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

  void updateProfile(technician) {
    final updatedData = {
      'phone': _controllers['phone']?.text,
      'skills': _controllers['skills']?.text,
      'experience': _controllers['experience']?.text,
      'educationLevel': _controllers['education_level']?.text,
      'availableLocation': _controllers['available_location']?.text,
      'additionalBio': _controllers['additional_bio']?.text,
      "status": technician.status
    };

    BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdateTechnicianProfile(technicianId: technician.id, updates: updatedData));
  }

  void updatePassword(id) {
    BlocProvider.of<IndividualTechnicianBloc>(context).add(UpdatePassword(id: id, role: 'technician', oldPassword: oldPasswordController.text, newPassword: newPasswordController.text));
    oldPasswordController.clear();
    newPasswordController.clear();
  }
}
