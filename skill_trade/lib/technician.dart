import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/presentation/screens/technician_profile.dart';
import 'package:skill_trade/presentation/themes.dart';
import 'package:skill_trade/presentation/widgets/technician_booking_list.dart';
import 'package:skill_trade/presentation/widgets/drawer.dart';
import 'package:skill_trade/state_managment/bookings/bookings_bloc.dart';
import 'package:skill_trade/state_managment/customer/customer_bloc.dart';
import 'package:skill_trade/state_managment/individual_technician/individual_technician_bloc.dart';

// void main() {
//   runApp(TechnicianPage());
// }

class TechnicianPage extends StatefulWidget {
  const TechnicianPage({super.key});

  @override
  State<TechnicianPage> createState() => _TechnicianPageState();
}

class _TechnicianPageState extends State<TechnicianPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const TechnicianBookingList(),
    const TechnicianProfile()
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Technician Page",
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CustomerBloc>(
            create: (BuildContext context) => CustomerBloc(),
          ),
          BlocProvider<BookingsBloc>(
            create: (BuildContext context) => BookingsBloc(),
          ),
          BlocProvider<IndividualTechnicianBloc>(
            create: (BuildContext context) => IndividualTechnicianBloc(),
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
          title: Text("SkillTrade"),
          centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Bookings"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "My Profile"
          ),
        
        ],
      ),
      ),
      )
    );
  }
}