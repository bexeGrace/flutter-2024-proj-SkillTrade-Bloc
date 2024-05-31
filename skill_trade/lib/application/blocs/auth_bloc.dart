import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/repositories/auth_repository.dart';
import 'package:skill_trade/presentation/events/auth_event.dart';
import 'package:skill_trade/presentation/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnLogged()) {
    on<AutomaticLogIn>(_onAutomaticLogIn);
    on<LogInEvent>(_onLogIn);
    on<SignUpCustomer>(_onSignUpCustomer);
    on<SignUpTechnician>(_onSignUpTechnician);
    on<UnlogEvent>(_onUnlogEvent);
    on<DeleteAccount>(_onDeleteAccount);
    add(AutomaticLogIn());
  }

  Future<void> _onAutomaticLogIn(AutomaticLogIn event, Emitter<AuthState> emit) async {
    final token = await authRepository.getToken();
    if (token != null) {
      final role = await authRepository.getRole();
      emit(LoggedIn(role: role!));
    }
  }

  Future<void> _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    try {
      final role = await authRepository.logIn(event.role, event.email, event.password);
      emit(LoggedIn(role: role));
    } catch (error) {
      emit(AuthError(error.toString().split(":")[1]));
    }
  }

  Future<void> _onSignUpCustomer(SignUpCustomer event, Emitter<AuthState> emit) async {
    try {
      await authRepository.signUpCustomer(event.email, event.password, event.phone, event.fullName);
      add(LogInEvent(role: "customer", email: event.email, password: event.password));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> _onSignUpTechnician(SignUpTechnician event, Emitter<AuthState> emit) async {
    try {
      await authRepository.signUpTechnician(event.email, event.password, event.phone, event.fullName, event.skills, event.experience, event.educationLevel, event.availableLocation, event.additionalBio);
      emit(AuthSuccess('Successfully applied'));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> _onUnlogEvent(UnlogEvent event, Emitter<AuthState> emit) async {
    await authRepository.clearData();
    emit(UnLogged());
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<AuthState> emit) async {
    await authRepository.deleteAccount();
    emit(UnLogged());
  }
}
