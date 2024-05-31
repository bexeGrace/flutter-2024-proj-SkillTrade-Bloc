import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/data_sources/bookings_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/data_sources/technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/bookings_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/infrastructure/repositories/technician_repository.dart';
import 'package:skill_trade/presentation/screens/customer_profile.dart';
import 'package:skill_trade/presentation/screens/customer_bookings.dart';
import 'package:skill_trade/presentation/screens/find_technicians.dart';
import 'package:skill_trade/presentation/themes.dart';
import 'package:skill_trade/presentation/widgets/drawer.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/application/blocs/find_technician_bloc.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:http/http.dart' as http;

class CustomerPageLogic {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    selectedIndex = index;
  }

  Widget getCurrentPage() {
    final List<Widget> pages = [
      const FindTechnician(),
      CustomerBookings(),
      const CustomerProfileScreen(),
    ];
    return pages[selectedIndex];
  }
}

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final CustomerPageLogic _logic = CustomerPageLogic();

  final customerRepository = CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: CustomerRemoteDataSourceImpl(client: http.Client()));

  @override
  Widget build(BuildContext context) {
    final bookingsRepository = BookingsRepositoryImpl(BookingsRemoteDataSourceImpl(http.Client()), SecureStorage.instance);

    return MaterialApp(
      title: "Customer Page",
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TechniciansBloc>(
            create: (BuildContext context) => TechniciansBloc(technicianRepository: TechnicianRepository(remoteDataSource: TechnicianRemoteDataSource())),
          ),
          BlocProvider<BookingsBloc>(
            create: (BuildContext context) => BookingsBloc(bookingsRepository: bookingsRepository),
          ),
          BlocProvider<IndividualTechnicianBloc>(
            create: (BuildContext context) => IndividualTechnicianBloc(individualTechnicianRepository: IndividualTechnicianRepository(remoteDataSource: IndividualTechnicianRemoteDataSource())),
          ),
          BlocProvider<CustomerBloc>(
            create: (BuildContext context) => CustomerBloc(customerRepository: customerRepository),
          ),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(Icons.menu),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            title: const Text("SkillTrade"),
            centerTitle: true,
          ),
          drawer: const MyDrawer(),
          body: _logic.getCurrentPage(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _logic.selectedIndex,
            onTap: (index) {
              setState(() {
                _logic.navigateBottomBar(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.build_outlined), label: "Find Technician"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined), label: "My Bookings"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "My Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
