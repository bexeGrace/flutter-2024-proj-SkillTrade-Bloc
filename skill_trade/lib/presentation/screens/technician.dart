import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/data_sources/bookings_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/individual_technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/bookings_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/individual_technician_repository.dart';
import 'package:skill_trade/presentation/screens/technician_profile.dart';
import 'package:skill_trade/presentation/themes.dart';
import 'package:skill_trade/presentation/widgets/technician_booking_list.dart';
import 'package:skill_trade/presentation/widgets/drawer.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:http/http.dart' as http;

class TechnicianPageLogic {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    selectedIndex = index;
  }

  Widget getCurrentPage() {
    final List<Widget> pages = [
      TechnicianBookingList(),
      const TechnicianProfile(),
    ];
    return pages[selectedIndex];
  }
}

class TechnicianPage extends StatefulWidget {
  const TechnicianPage({super.key});

  @override
  State<TechnicianPage> createState() => _TechnicianPageState();
}

class _TechnicianPageState extends State<TechnicianPage> {
  final TechnicianPageLogic _logic = TechnicianPageLogic();

  final customerRepository = CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: CustomerRemoteDataSourceImpl(client: http.Client()));
  final bookingsRepository = BookingsRepositoryImpl(BookingsRemoteDataSourceImpl(http.Client()), SecureStorage.instance);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Technician Page",
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CustomerBloc>(
            create: (BuildContext context) => CustomerBloc(customerRepository: customerRepository),
          ),
          BlocProvider<BookingsBloc>(
            create: (BuildContext context) => BookingsBloc(bookingsRepository: bookingsRepository),
          ),
          BlocProvider<IndividualTechnicianBloc>(
            create: (BuildContext context) => IndividualTechnicianBloc(individualTechnicianRepository: IndividualTechnicianRepository(remoteDataSource: IndividualTechnicianRemoteDataSource())),
          ),
        ],
        child: Scaffold(
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
                icon: Icon(Icons.book_outlined),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: "My Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
