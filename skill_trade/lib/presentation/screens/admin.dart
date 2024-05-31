import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/data_sources/customer_remote_data_source_impl.dart';
import 'package:skill_trade/infrastructure/data_sources/technician_remote_data_source.dart';
import 'package:skill_trade/infrastructure/repositories/customer_repository_impl.dart';
import 'package:skill_trade/infrastructure/repositories/technician_repository.dart';
import 'package:skill_trade/presentation/screens/admin_page.dart';
import 'package:skill_trade/presentation/screens/technicians_list.dart';
import 'package:skill_trade/presentation/screens/admin_users_page.dart';
import 'package:skill_trade/presentation/screens/reported_technicians.dart';
import 'package:skill_trade/presentation/widgets/drawer.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/application/blocs/find_technician_bloc.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';
import 'package:http/http.dart' as http;

class AdminSiteLogic {
  int currentIndex = 0;

  void onItemTapped(BuildContext context, int index) {
    currentIndex = index;
  }
  final customerRepository = CustomerRepositoryImpl(secureStorage: SecureStorage.instance, remoteDataSource: CustomerRemoteDataSourceImpl(client: http.Client()));

  Widget getCurrentPage() {
    switch (currentIndex) {
      case 0:
        return MultiBlocProvider(
        providers: [
          BlocProvider<TechniciansBloc>(
            create: (BuildContext context) => TechniciansBloc(technicianRepository: TechnicianRepository(remoteDataSource: TechnicianRemoteDataSource())),
          ),
        ],
        child: const AdminPage()
      );
      case 1:
        return MultiBlocProvider(
        providers: [
          BlocProvider<TechniciansBloc>(
            create: (BuildContext context) => TechniciansBloc(technicianRepository: TechnicianRepository(remoteDataSource: TechnicianRemoteDataSource())),
          ),
        ],
        child: const ReportedTechnicians()
      );
      case 2:
        return MultiBlocProvider(
        providers: [
          BlocProvider<CustomerBloc>(
            create: (BuildContext context) => CustomerBloc(customerRepository: customerRepository),
          ),
        ],
        child: const CustomersList()
      );
      case 3:
        return MultiBlocProvider(
        providers: [
          BlocProvider<TechniciansBloc>(
            create: (BuildContext context) => TechniciansBloc(technicianRepository: TechnicianRepository(remoteDataSource: TechnicianRemoteDataSource())),
          ),
        ],
        child: const TechniciansList()
      );
      default:
        return  MultiBlocProvider(
        providers: [
          BlocProvider<TechniciansBloc>(
            create: (BuildContext context) => TechniciansBloc(technicianRepository: TechnicianRepository(remoteDataSource: TechnicianRemoteDataSource())),
          ),
        ],
        child: const AdminPage()
      );
    }
  }
}

class AdminSite extends StatefulWidget {
  const AdminSite({super.key});

  @override
  _AdminSiteState createState() => _AdminSiteState();
}

class _AdminSiteState extends State<AdminSite> {
  final AdminSiteLogic _logic = AdminSiteLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkillTrade'),
        centerTitle: true,
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
      ),
      drawer: const MyDrawer(),
      body: _logic.getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _logic.currentIndex,
        onTap: (index) {
          setState(() {
            _logic.onItemTapped(context, index);
          });
        },
        iconSize: 24,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_copy,
              size: 20,
            ),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.warning,
              size: 20,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search,
              size: 20,
            ),
            label: 'Technicians',
          ),
        ],
      ),
    );
  }
}
