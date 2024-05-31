import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/repositories/auth_repository.dart';
import 'package:skill_trade/application/blocs/auth_bloc.dart';
import 'package:skill_trade/presentation/events/auth_event.dart';
import 'package:skill_trade/presentation/states/auth_state.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'emits [LoggedIn] when AutomaticLogIn event is added and token is found',
      setUp: () {
        when(mockAuthRepository.getToken()).thenAnswer((_) async => 'some-token');
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'customer');
      },
      build: () {
        authBloc = AuthBloc(authRepository: mockAuthRepository);
        return authBloc;
      },
      expect: () => [LoggedIn(role: 'customer')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when LogInEvent is added and login fails',
      setUp: () {
        when(mockAuthRepository.getToken()).thenAnswer((_) async => null);
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'customer');
      },
      build: () {
        when(mockAuthRepository.logIn('customer', 'test@example.com', 'password')).thenThrow(Exception('Login Failed'));
        authBloc = AuthBloc(authRepository: mockAuthRepository);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInEvent(role: 'customer', email: 'test@example.com', password: 'password')),
      expect: () => [AuthError('Exception: Login Failed')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when SignUpCustomer is added and signup fails',
      setUp: () {
        when(mockAuthRepository.getToken()).thenAnswer((_) async => null);
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'customer');
      },
      build: () {
        when(mockAuthRepository.signUpCustomer('test@example.com', 'password', '1234567890', 'Test User')).thenThrow(Exception('Signup Failed'));
        authBloc = AuthBloc(authRepository: mockAuthRepository);
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpCustomer(email: 'test@example.com', password: 'password', phone: '1234567890', fullName: 'Test User')),
      expect: () => [AuthError('Exception: Signup Failed')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthSuccess] when SignUpTechnician is added and signup succeeds',
      setUp: () {
        when(mockAuthRepository.getToken()).thenAnswer((_) async => 'some-token');
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'customer');
      },
      build: () {
        when(mockAuthRepository.signUpTechnician(
          'test@example.com', 
          'password', 
          '1234567890', 
          'Test User', 
          'skills', 
          'experience', 
          'educationLevel', 
          'location', 
          'bio'
        )).thenAnswer((_) async => Future.value());
        authBloc = AuthBloc(authRepository: mockAuthRepository);
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpTechnician(
        email: 'test@example.com', 
        password: 'password', 
        phone: '1234567890', 
        fullName: 'Test User', 
        skills: 'skills', 
        experience: 'experience', 
        educationLevel: 'educationLevel', 
        availableLocation: 'location', 
        additionalBio: 'bio'
      )),
      expect: () => [LoggedIn(role: 'technician'), AuthSuccess('Successfully applied')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [UnLogged] when UnlogEvent is added',
      setUp: () {
        when(mockAuthRepository.getToken()).thenAnswer((_) async => null);
        when(mockAuthRepository.getRole()).thenAnswer((_) async => 'customer');
      },
      build: () {
        when(mockAuthRepository.clearData()).thenAnswer((_) async => Future.value());
        authBloc = AuthBloc(authRepository: mockAuthRepository);
        return authBloc;
      },
      act: (bloc) => bloc.add(UnlogEvent()),
      expect: () => [UnLogged()],
    );
  });
}
