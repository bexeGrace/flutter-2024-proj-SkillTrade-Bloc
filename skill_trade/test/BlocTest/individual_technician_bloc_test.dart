import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';

import 'individual_technician_bloc_test.mocks.dart';

@GenerateMocks([IndividualTechnicianRepository])
void main() {
  late MockIndividualTechnicianRepository mockIndividualTechnicianRepository;
  late IndividualTechnicianBloc individualTechnicianBloc;

  setUp(() {
    mockIndividualTechnicianRepository = MockIndividualTechnicianRepository();
  });

  tearDown(() {
    individualTechnicianBloc.close();
  });

  group('IndividualTechnicianBloc', () {
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

    blocTest<IndividualTechnicianBloc, IndividualTechnicianState>(
      'emits [IndividualTechnicianLoading, IndividualTechnicianLoaded] when LoadIndividualTechnician event is added',
      setUp: () {
        when(mockIndividualTechnicianRepository.getIndividualTechnician('1')).thenAnswer((_) async => technician);
      },
      build: () {
        individualTechnicianBloc = IndividualTechnicianBloc(individualTechnicianRepository: mockIndividualTechnicianRepository);
        return individualTechnicianBloc;
      },
      act: (bloc) => bloc.add(LoadIndividualTechnician(technicianId: 1)),
      expect: () => [IndividualTechnicianLoaded(technician: technician)],
    );

    blocTest<IndividualTechnicianBloc, IndividualTechnicianState>(
      'emits [IndividualTechnicianLoading, IndividualTechnicianError] when LoadIndividualTechnician event is added and an error occurs',
      setUp: () {
        when(mockIndividualTechnicianRepository.getIndividualTechnician('1')).thenThrow(Exception('Failed to load technician'));
      },
      build: () {
        individualTechnicianBloc = IndividualTechnicianBloc(individualTechnicianRepository: mockIndividualTechnicianRepository);
        return individualTechnicianBloc;
      },
      act: (bloc) => bloc.add(LoadIndividualTechnician(technicianId: 1)),
      expect: () => [IndividualTechnicianError('Exception: Failed to load technician')],
    );

    blocTest<IndividualTechnicianBloc, IndividualTechnicianState>(
      'emits [IndividualTechnicianLoading, IndividualTechnicianLoaded] when UpdateTechnicianProfile event is added and profile is updated successfully',
      setUp: () {
        when(mockIndividualTechnicianRepository.updateTechnicianProfile('1', any)).thenAnswer((_) async => Future.value());
        when(mockIndividualTechnicianRepository.getIndividualTechnician('1')).thenAnswer((_) async => technician);
      },
      build: () {
        individualTechnicianBloc = IndividualTechnicianBloc(individualTechnicianRepository: mockIndividualTechnicianRepository);
        return individualTechnicianBloc;
      },
      act: (bloc) => bloc.add(UpdateTechnicianProfile(technicianId: 1, updates: {'status': 'active'})),
      expect: () => [IndividualTechnicianLoaded(technician: technician)],
    );

    blocTest<IndividualTechnicianBloc, IndividualTechnicianState>(
      'emits [IndividualTechnicianLoading, IndividualTechnicianError] when UpdateTechnicianProfile event is added and an error occurs',
      setUp: () {
        when(mockIndividualTechnicianRepository.updateTechnicianProfile('1', any)).thenThrow(Exception('Failed to update profile'));
      },
      build: () {
        individualTechnicianBloc = IndividualTechnicianBloc(individualTechnicianRepository: mockIndividualTechnicianRepository);
        return individualTechnicianBloc;
      },
      act: (bloc) => bloc.add(UpdateTechnicianProfile(technicianId: 1, updates: {'status': 'active'})),
      expect: () => [IndividualTechnicianError('Exception: Failed to update profile')],
    );
  });
}
