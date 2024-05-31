import 'package:equatable/equatable.dart';

abstract class TechniciansEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadTechnicians extends TechniciansEvent {
  @override
  List<Object?> get props => [];
}

class LoadPendingTechnicians extends TechniciansEvent {
  @override
  List<Object?> get props => [];
}

class LoadSuspendedTechnicians extends TechniciansEvent {
  @override
  List<Object?> get props => [];
}