import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/infrastructure/repositories/technician_repository.dart';
import 'package:skill_trade/application/blocs/find_technician_bloc.dart';
import 'package:skill_trade/presentation/events/find_technician_event.dart';
import 'package:skill_trade/presentation/states/find_technician_state.dart';

import 'find_technician_test.mocks.dart';

@GenerateMocks([TechnicianRepository])
void main() {
  late MockTechnicianRepository mockTechnicianRepository;
  late TechniciansBloc techniciansBloc;

  setUp(() {
    mockTechnicianRepository = MockTechnicianRepository();
  });

  tearDown(() {
    techniciansBloc.close();
  });

  group('TechniciansBloc', () {
    final technician = Technician(
      id: 1,
      skills: 'some',
      experience: 'required',
      education_level: 'level',
      available_location: 'location',
      additional_bio: 'why',
      phone: '0987654',
      name: 'Techie Smith',
      email: 'techiesmith@example.com',
      status: 'active',
    );

    final technicians = [
      Technician(
      id: 1,
      skills: 'some',
      experience: 'required',
      education_level: 'level',
      available_location: 'location',
      additional_bio: 'why',
      phone: '0987654',
      name: 'Techie Smith',
      email: 'techiesmith@example.com',
      status: 'active',
    ),
      Technician(
      id: 1,
      skills: 'some',
      experience: 'required',
      education_level: 'level',
      available_location: 'location',
      additional_bio: 'why',
      phone: '0987654',
      name: 'Techie Smith',
      email: 'techiesmith@example.com',
      status: 'active',
    ),
    ];

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, TechniciansLoaded] when LoadTechnicians event is added',
      setUp: () {
        when(mockTechnicianRepository.getTechnicians()).thenAnswer((_) async => technicians);
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicians()),
      expect: () => [TechniciansLoaded(technicians)],
    );

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, PendingTechniciansLoaded] when LoadPendingTechnicians event is added',
      setUp: () {
        when(mockTechnicianRepository.getPendingTechnicians()).thenAnswer((_) async => technicians);
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadPendingTechnicians()),
      expect: () => [PendingTechniciansLoaded(technicians)],
    );

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, SuspendedTechniciansLoaded] when LoadSuspendedTechnicians event is added',
      setUp: () {
        when(mockTechnicianRepository.getSuspendedTechnicians()).thenAnswer((_) async => technicians);
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadSuspendedTechnicians()),
      expect: () => [SuspendedTechniciansLoaded(technicians)],
    );

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, TechniciansError] when LoadTechnicians event is added and an error occurs',
      setUp: () {
        when(mockTechnicianRepository.getTechnicians()).thenThrow(Exception('Failed to load technicians'));
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicians()),
      expect: () => [TechniciansError('Exception: Failed to load technicians')],
    );

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, TechniciansError] when LoadPendingTechnicians event is added and an error occurs',
      setUp: () {
        when(mockTechnicianRepository.getPendingTechnicians()).thenThrow(Exception('Failed to load pending technicians'));
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadPendingTechnicians()),
      expect: () => [TechniciansError('Exception: Failed to load pending technicians')],
    );

    blocTest<TechniciansBloc, TechniciansState>(
      'emits [TechniciansLoading, TechniciansError] when LoadSuspendedTechnicians event is added and an error occurs',
      setUp: () {
        when(mockTechnicianRepository.getSuspendedTechnicians()).thenThrow(Exception('Failed to load suspended technicians'));
      },
      build: () {
        techniciansBloc = TechniciansBloc(technicianRepository: mockTechnicianRepository);
        return techniciansBloc;
      },
      act: (bloc) => bloc.add(LoadSuspendedTechnicians()),
      expect: () => [TechniciansError('Exception: Failed to load suspended technicians')],
    );
  });
}
