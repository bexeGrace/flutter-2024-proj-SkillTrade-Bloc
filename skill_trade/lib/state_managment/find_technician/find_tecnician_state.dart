import 'package:skill_trade/models/technician.dart';

abstract class TechniciansState {}

class TechniciansLoading extends TechniciansState {}

class TechniciansLoaded extends TechniciansState {
  final List<Technician> technicians;

  TechniciansLoaded(this.technicians);
}

class PendingTechniciansLoaded extends TechniciansState {
  final List<Technician> technicians;

  PendingTechniciansLoaded(this.technicians);
}

class SuspendedTechniciansLoaded extends TechniciansState {
  final List<Technician> technicians;

  SuspendedTechniciansLoaded(this.technicians);
}

class TechniciansError extends TechniciansState {
  final String error;

  TechniciansError(this.error);
}