import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_trade/domain/models/customer.dart';
import 'package:skill_trade/domain/repositories/auth_repository.dart';
import 'package:skill_trade/infrastructure/data_sources/bookings_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/review_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/auth_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/bookings_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/infrastructure/repositories/review_repository.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.instance.init();
  final httpClient = http.Client();
  final remoteDataSource = RemoteDataSource(httpClient);
  final bookingRemoteDataSource = BookingsRemoteDataSourceImpl(httpClient);
  final customerRemoteDataSource = CustomerRemoteDataSourceImpl(client: httpClient);

  final authRepository = AuthRepositoryImpl(remoteDataSource, SecureStorage.instance);
  final bookingsRepository = BookingsRepositoryImpl(bookingRemoteDataSource, SecureStorage.instance);
  final customerRepository = CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: customerRemoteDataSource,);

  runApp(MyApp(authRepository: authRepository, bookingsRepository: bookingsRepository, customerRepository: customerRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;  
  final BookingsRepositoryImpl bookingsRepository;
  final CustomerRepositoryImpl customerRepository;

  MyApp({required this.authRepository, required this.bookingsRepository, required this.customerRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<IndividualTechnicianBloc>(
          create: (BuildContext context) => IndividualTechnicianBloc(individualTechnicianRepository: IndividualTechnicianRepository(remoteDataSource: IndividualTechnicianRemoteDataSource())),
        ),
        BlocProvider<BookingsBloc>(
          create: (BuildContext context) => BookingsBloc(bookingsRepository: bookingsRepository),
        ),
        BlocProvider<ReviewsBloc>(
          create: (BuildContext context) => ReviewsBloc(reviewRepository: ReviewRepository(remoteDataSource: ReviewRemoteDataSource())),
        ),
        BlocProvider<CustomerBloc>(
          create: (BuildContext context) => CustomerBloc(customerRepository: customerRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GetFirstPage(),
    ),
    GoRoute(
      path: '/admintech',
      builder: (context, state) {
          final technicianId = state.extra as int;
          return MultiBlocProvider(
            providers: [
              BlocProvider<ReviewsBloc>(
                create: (context) => ReviewsBloc(reviewRepository: ReviewRepository(remoteDataSource: ReviewRemoteDataSource())),
              ),
            ],
            child: AdminTechnician(technicianId: technicianId,),
          );
        },
    ),
    GoRoute(
      path: '/admincustomer',
      builder: (context, state) {
          final customer = state.extra as Customer;
          return AdminCustomer(customer: customer,);
        },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/customer',
      builder: (context, state) => CustomerPage(),
    ),
    GoRoute(
      path: '/technician',
      builder: (context, state) => TechnicianPage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => AdminSite(),
    ),
    GoRoute(
      path: '/apply',
      builder: (context, state) => TechnicianApplicationSuccess(),
    ),
    GoRoute(
        path: '/myBookings',
        builder: (context, state) {
          final technician = state.extra as Technician;
          final bookingsRepository = (context as Element).findAncestorWidgetOfExactType<MyApp>()?.bookingsRepository;
          final customerRepository = (context as Element).findAncestorWidgetOfExactType<MyApp>()?.customerRepository;

          if (bookingsRepository != null && customerRepository != null) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ReviewsBloc>(
                  create: (context) => ReviewsBloc(reviewRepository: ReviewRepository(remoteDataSource: ReviewRemoteDataSource())),
                ),
                BlocProvider<BookingsBloc>(
                  create: (context) => BookingsBloc(bookingsRepository: bookingsRepository),
                ),
                BlocProvider<CustomerBloc>(
                  create: (context) => CustomerBloc(customerRepository: customerRepository),
                ),
              ],
              child: MyBookings(technician: technician),
            );
          } else {
          throw Exception('BookingsRepository or customerRepository not found');
        }
        },
      ),
  ],
);

class GetFirstPageLogic {
  Widget getLoggedInPage(String role) {
    switch (role) {
      case "customer":
        return const CustomerPage();
      case "technician":
        return const TechnicianPage();
      case "admin":
        return const AdminSite();
      default:
        return const HomeScreen();
    }
  }
}

class GetFirstPage extends StatelessWidget {
  const GetFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is LoggedIn) {
          print('User is logged in as ${state.role}');
          return GetFirstPageLogic().getLoggedInPage(state.role!);
        } else {
          print('User is not logged in');
          return const HomeScreen();
        }
      },
    );
  }
}
