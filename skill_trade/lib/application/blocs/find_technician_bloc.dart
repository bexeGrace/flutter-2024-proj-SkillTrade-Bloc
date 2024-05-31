import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/repositories/technician_repository.dart';
import 'package:skill_trade/presentation/events/find_technician_event.dart';
import 'package:skill_trade/presentation/states/find_technician_state.dart';

class TechniciansBloc extends Bloc<TechniciansEvent, TechniciansState> {
  final TechnicianRepository technicianRepository;

  TechniciansBloc({required this.technicianRepository}) : super(TechniciansLoading()) {
    on<LoadTechnicians>(_onLoadTechnicians);
    on<LoadPendingTechnicians>(_onLoadPendingTechnicians);
    on<LoadSuspendedTechnicians>(_onLoadSuspendedTechnicians);
  }

  Future<void> _onLoadTechnicians(LoadTechnicians event, Emitter<TechniciansState> emit) async {
    try {
      final technicians = await technicianRepository.getTechnicians();
      emit(TechniciansLoaded(technicians));
    } catch (error) {
      emit(TechniciansError(error.toString()));
    }
  }

  Future<void> _onLoadPendingTechnicians(LoadPendingTechnicians event, Emitter<TechniciansState> emit) async {
    try {
      final technicians = await technicianRepository.getPendingTechnicians();
      emit(PendingTechniciansLoaded(technicians));
    } catch (error) {
      emit(TechniciansError(error.toString()));
    }
  }

  Future<void> _onLoadSuspendedTechnicians(LoadSuspendedTechnicians event, Emitter<TechniciansState> emit) async {
    try {
      final technicians = await technicianRepository.getSuspendedTechnicians();
      emit(SuspendedTechniciansLoaded(technicians));
    } catch (error) {
      emit(TechniciansError(error.toString()));
    }
  }
}
