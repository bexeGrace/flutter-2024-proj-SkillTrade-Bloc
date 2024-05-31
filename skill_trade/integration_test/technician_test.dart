import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:skill_trade/main.dart';
import 'package:skill_trade/infrastructure/data_sources/bookings_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/auth_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/bookings_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/presentation/screens/customer.dart';
import 'package:skill_trade/presentation/screens/home_page.dart';
import 'package:skill_trade/presentation/screens/login_page.dart';
import 'package:skill_trade/presentation/screens/signup_page.dart';
import 'package:http/http.dart' as http;
import 'package:skill_trade/presentation/screens/technician.dart';
import 'package:skill_trade/presentation/widgets/technician_application.dart';
// class MockAuthBloc extends Mock implements AuthBloc {}
void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.instance.init();
  final httpClient = http.Client();
  final remoteDataSource = RemoteDataSource(httpClient);
  final bookingRemoteDataSource = BookingsRemoteDataSourceImpl(httpClient);
  final customerRemoteDataSource = CustomerRemoteDataSourceImpl(client: httpClient);
  final authRepository = AuthRepositoryImpl(remoteDataSource, SecureStorage.instance);
  final bookingsRepository = BookingsRepositoryImpl(bookingRemoteDataSource, SecureStorage.instance);
  final customerRepository = CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: customerRemoteDataSource,);


group('Technician Signup and Login Tests', () {
    testWidgets('Technician Login', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, customerRepository: customerRepository, bookingsRepository: bookingsRepository));
      await tester.pumpAndSettle(); 

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Verify that HomeScreen is displayed
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('SkillTrade Hub'), findsOneWidget);

      // Tap the login button
      final loginButtonFinder = find.text('Login');
      await tester.ensureVisible(loginButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();

      // Verify that LoginPage is displayed
      expect(find.byType(LoginPage), findsOneWidget);

      // Enter email
      await tester.enterText(find.bySemanticsLabel('email'), 'jane.smith@example.com');
      // Enter password
      await tester.enterText(find.bySemanticsLabel('password'), 'password123');

      // Dismiss the keyboard
      await tester.tapAt(Offset(0, 0));
      await tester.pumpAndSettle();

      final technicianRadioFinder = find.text('Technician').hitTestable();
      await tester.tap(technicianRadioFinder);
      await tester.pumpAndSettle();



      // Scroll the login button into view
      final loginButtonFinderForm = find.text('login');
      await tester.ensureVisible(loginButtonFinderForm);
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(loginButtonFinderForm);

      // Wait for backend response and app to settle
      await tester.pumpAndSettle();

      // Verify that TechnicianPage is displayed after login
      expect(await find.byType(TechnicianPage), findsOneWidget);
    });
  }, skip: "skip for now");
}