// Mocks generated by Mockito 5.4.4 from annotations
// in skill_trade/test/auth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:skill_trade/domain/repositories/auth_repository.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i2.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> logIn(
    String? role,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [
            role,
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #logIn,
            [
              role,
              email,
              password,
            ],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<void> signUpCustomer(
    String? email,
    String? password,
    String? phone,
    String? fullName,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpCustomer,
          [
            email,
            password,
            phone,
            fullName,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> signUpTechnician(
    String? email,
    String? password,
    String? phone,
    String? fullName,
    String? skills,
    String? experience,
    String? educationLevel,
    String? availableLocation,
    String? additionalBio,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpTechnician,
          [
            email,
            password,
            phone,
            fullName,
            skills,
            experience,
            educationLevel,
            availableLocation,
            additionalBio,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<String?> getToken() => (super.noSuchMethod(
        Invocation.method(
          #getToken,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);

  @override
  _i3.Future<String?> getRole() => (super.noSuchMethod(
        Invocation.method(
          #getRole,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);

  @override
  _i3.Future<void> clearData() => (super.noSuchMethod(
        Invocation.method(
          #clearData,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteAccount() => (super.noSuchMethod(
        Invocation.method(
          #deleteAccount,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
