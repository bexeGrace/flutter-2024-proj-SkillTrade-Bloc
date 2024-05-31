

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


  group('Customer Login', () {
    testWidgets('Login flow', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, customerRepository: customerRepository, bookingsRepository: bookingsRepository));
      await tester.pumpAndSettle(); 

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('SkillTrade Hub'), findsOneWidget);

      final loginButtonFinder = find.text('login');
      await tester.ensureVisible(loginButtonFinder);
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);

      await tester.enterText(find.bySemanticsLabel('email'), 'john.doe@example.com');
  
      await tester.enterText(find.bySemanticsLabel('password'), 'password123');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      final customerRadioFinder = find.text('Customer').hitTestable();
      await tester.tap(customerRadioFinder);
      await tester.pumpAndSettle();

      final loginButtonFinderForm = find.text('login');
      await tester.ensureVisible(loginButtonFinderForm);
      await tester.tap(loginButtonFinderForm);
      await tester.pumpAndSettle();

      expect(await find.byType(CustomerPage), findsOneWidget);
    });
  });
}