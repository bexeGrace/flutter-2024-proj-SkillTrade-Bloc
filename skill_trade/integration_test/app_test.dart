import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:skill_trade/main.dart'; // Adjust the import to your app's entry point
// import 'package:skill_trade/bloc/my_bloc.dart'; // Adjust the import to your BLoC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/domain/repositories/auth_repository.dart';
import 'package:skill_trade/infrastructure/data_sources/bookings_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/review_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/auth_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/bookings_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/infrastructure/repositories/review_repository.dart';
import 'package:skill_trade/presentation/events/auth_event.dart';
import 'package:skill_trade/presentation/screens/admin.dart';
import 'package:skill_trade/presentation/screens/customer.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/screens/admin_customer.dart';
import 'package:skill_trade/presentation/screens/admin_technician.dart';
import 'package:skill_trade/presentation/screens/bookings.dart';
import 'package:skill_trade/presentation/screens/home_page.dart';
import 'package:skill_trade/presentation/screens/login_page.dart';
import 'package:skill_trade/presentation/screens/signup_page.dart';
import 'package:skill_trade/presentation/screens/technician_application_success.dart';
import 'package:skill_trade/presentation/themes.dart';
import 'package:skill_trade/application/blocs/auth_bloc.dart';
import 'package:skill_trade/presentation/states/auth_state.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:skill_trade/presentation/screens/technician.dart';
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
      await tester.pumpAndSettle();

      // Verify navigation to CustomerPage
      expect(find.byType(CustomerPage), findsOneWidget);
    });
  }, skip: "skipping signup test for now");

  group('Customer Login', () {
    testWidgets('Login flow', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(authRepository: authRepository, customerRepository: customerRepository, bookingsRepository: bookingsRepository));
      await tester.pumpAndSettle(); // Wait for the app to settle

      // Verify that HomeScreen is displayed
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('SkillTrade Hub'), findsOneWidget);

      // Navigate to the login page
      final loginButtonFinder = find.text('login');
      await tester.ensureVisible(loginButtonFinder);
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);

      // Enter email
      await tester.enterText(find.bySemanticsLabel('email'), 'john.doe@example.com');
      // Enter password
      await tester.enterText(find.bySemanticsLabel('password'), 'password123');

      // Dismiss the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Select customer role
      final customerRadioFinder = find.text('Customer').hitTestable();
      await tester.tap(customerRadioFinder);
      await tester.pumpAndSettle();

      // Tap the login button
      final loginButtonFinderForm = find.text('login');
      await tester.ensureVisible(loginButtonFinderForm);
      await tester.tap(loginButtonFinderForm);
      await tester.pumpAndSettle();

      // Verify navigation to CustomerPage
      expect(await find.byType(CustomerPage), findsOneWidget);
    });
  });
}



