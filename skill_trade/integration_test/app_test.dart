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
import 'package:skill_trade/presentation/screens/bookings.dart';
import 'package:skill_trade/presentation/screens/customer.dart';
import 'package:skill_trade/presentation/screens/home_page.dart';
import 'package:skill_trade/presentation/screens/signup_page.dart';
import 'package:http/http.dart' as http;
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


  group('Customer Signup', () {
    testWidgets('Signup flow', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, customerRepository: customerRepository, bookingsRepository: bookingsRepository));
      await tester.pumpAndSettle(); // Wait for the app to settle

      // Verify that HomeScreen is displayed
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('SkillTrade Hub'), findsOneWidget);

      // Navigate to the signup page
      final signupButtonFinder = find.text('Sign up');
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(SignupPage), findsOneWidget);

      // Enter full name
      await tester.enterText(find.bySemanticsLabel('Fullname'), 'John Doe');
      // Enter email
      await tester.enterText(find.bySemanticsLabel('email'), 'john.doe@example.com');
      // Enter phone
      await tester.enterText(find.bySemanticsLabel('phone'), '1234567890');
      // Enter password
      await tester.enterText(find.bySemanticsLabel('password'), 'password123');

      // Dismiss the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Tap the signup button
      final signupButtonFinderForm = find.text('signup');
      await tester.ensureVisible(signupButtonFinderForm);
      await tester.tap(signupButtonFinderForm);
      await tester.pumpAndSettle(Duration(milliseconds:5000));


      // Verify navigation to CustomerPage
      expect(find.byType(CustomerPage), findsOneWidget);

      
      final findTechnicianButtonFinder = find.text('Get Technician').first;
      await tester.tap(findTechnicianButtonFinder);
      await tester.pumpAndSettle();


      expect(find.byType(MyBookings), findsOneWidget);

      await tester.tap(find.text('Select Date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('21'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.enterText(find.bySemanticsLabel('Service Needed'), 'Fix AC');
      await tester.enterText(find.bySemanticsLabel('Service Location'), '123 Main St');
      await tester.enterText(find.bySemanticsLabel('Problem Description'), 'Air conditioner not cooling properly.');

      final bookButtonFinder = find.text('Book');
      await tester.ensureVisible(bookButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(bookButtonFinder);
      await tester.pumpAndSettle();

    });
  },);

}



