import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';

class IndividualTechnicianBloc extends Bloc<IndividualTechnicianEvent, IndividualTechnicianState> {
  final IndividualTechnicianRepository individualTechnicianRepository;

  IndividualTechnicianBloc({required this.individualTechnicianRepository}) : super(IndividualTechnicianLoading()) {
    on<LoadIndividualTechnician>(_onLoadIndividualTechnician);
    on<UpdateTechnicianProfile>(_onUpdateTechnicianProfile);
    on<UpdatePassword>(_onUpdatePassword);
  }

  Future<void> _onLoadIndividualTechnician(LoadIndividualTechnician event, Emitter<IndividualTechnicianState> emit) async {    
    try {
      final technician = await individualTechnicianRepository.getIndividualTechnician(event.technicianId!.toString());
      emit(IndividualTechnicianLoaded(technician: technician));
    } catch (error) {
      emit(IndividualTechnicianError(error.toString()));
    }
  }

  Future<void> _onUpdateTechnicianProfile(UpdateTechnicianProfile event, Emitter<IndividualTechnicianState> emit) async {
    try {
      await individualTechnicianRepository.updateTechnicianProfile(event.technicianId.toString(), event.updates);
      add(LoadIndividualTechnician(technicianId: event.technicianId));
    } catch (error) {
      emit(IndividualTechnicianError(error.toString()));
    }
  }

  Future<void> _onUpdatePassword(UpdatePassword event, Emitter<IndividualTechnicianState> emit) async {
    try {
      await individualTechnicianRepository.updatePassword(
        {
          "role": event.role,
          "id": event.id,
          "newPassword": event.newPassword,
          "password": event.oldPassword
        }
      );
    } catch (error) {
      emit(IndividualTechnicianError(error.toString()));
    }
  }
}
