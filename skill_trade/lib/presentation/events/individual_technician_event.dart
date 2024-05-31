import 'package:equatable/equatable.dart';

abstract class IndividualTechnicianEvent extends Equatable {
  const IndividualTechnicianEvent();

  @override
  List<Object?> get props => [];
}

class LoadIndividualTechnician extends IndividualTechnicianEvent {
  final int? technicianId;

  const LoadIndividualTechnician({required this.technicianId});

  @override
  List<Object?> get props => [technicianId];
}

class UpdateTechnicianProfile extends IndividualTechnicianEvent {
  final Map<String, dynamic> updates;
  final int technicianId;

  const UpdateTechnicianProfile({
    required this.updates,
    required this.technicianId,
  });

  @override
  List<Object?> get props => [updates, technicianId];
}

class UpdatePassword extends IndividualTechnicianEvent {
  final int id;
  final String role;
  final String oldPassword;
  final String newPassword;

  const UpdatePassword({
    required this.id,
    required this.role,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [id, role, oldPassword, newPassword];
}
