import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpCustomer extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const SignUpCustomer({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, phone, password];
}

class SignUpTechnician extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String skills;
  final String experience;
  final String educationLevel;
  final String availableLocation;
  final String additionalBio;

  const SignUpTechnician({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.skills,
    required this.experience,
    required this.educationLevel,
    required this.availableLocation,
    required this.additionalBio,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        phone,
        password,
        skills,
        experience,
        educationLevel,
        availableLocation,
        additionalBio,
      ];
}

class LogInEvent extends AuthEvent {
  final String role;
  final String email;
  final String password;

  const LogInEvent({
    required this.role,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [role, email, password];
}

class UnlogEvent extends AuthEvent {
  const UnlogEvent();

  @override
  List<Object?> get props => [];
}

class AutomaticLogIn extends AuthEvent {
  const AutomaticLogIn();

  @override
  List<Object?> get props => [];
}

class DeleteAccount extends AuthEvent {
  const DeleteAccount();

  @override
  List<Object?> get props => [];
}
