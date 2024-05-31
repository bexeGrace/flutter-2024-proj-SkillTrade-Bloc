import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
import 'package:skill_trade/presentation/widgets/info_label.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';

class CustomerBooking extends StatefulWidget {
  final Booking booking;
  final Technician technician;
  final String customerId;
  CustomerBooking({super.key, required this.booking, required this.technician, required this.customerId}): 
    _controllers = {
      "serviceNeeded": TextEditingController(text: booking.serviceNeeded),
      "problemDescription": TextEditingController(text: booking.problemDescription),
      "serviceLocation": TextEditingController(text: booking.serviceLocation),
    }, 
    _selectedDate = booking.serviceDate;

  late DateTime? _selectedDate;
  final Map<String, TextEditingController> _controllers;

  @override
  State<CustomerBooking> createState() => _CustomerBookingState();
}

class _CustomerBookingState extends State<CustomerBooking> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget._selectedDate,
      firstDate: DateTime(2010), 
      lastDate: DateTime(2050), 
    );
    if (picked != null && picked != widget._selectedDate) {
      setState(() {
        widget._selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Booked With",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15,),
          Text(
            widget.technician.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 7,),
          InfoLabel(label: "Email", data: widget.technician.email),
          SizedBox(height: 7,),
          InfoLabel(label: "Speciality", data: widget.technician.skills),
          SizedBox(height: 7,),
          InfoLabel(label: "Phone", data: widget.technician.phone),
          SizedBox(height: 20,),


          InfoLabel(label: "Booked Date", data: widget.booking.bookedDate.toString().substring(0, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Service Date:  ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget._selectedDate.toString().substring(0, 10),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
                
              ),
              TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Change Date'),
                  ),
            ],
          ),
          EditableField(label: "Service Needed", data: widget.booking.serviceNeeded, controller: widget._controllers["serviceNeeded"],),
          EditableField(label: "Problem Description", data: widget.booking.problemDescription, controller: widget._controllers["problemDescription"],),
          EditableField(label: "Service Location", data: widget.booking.serviceLocation, controller: widget._controllers["serviceLocation"],),
          InfoLabel(label: "Status", data: widget.booking.status,),
          SizedBox(height: 15,),
          Row(
            children: [
              ElevatedButton(
                onPressed: editBooking, 
                child: Text("Edit", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)
                ),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                onPressed: deleteBooking, 
                child: Text("Delete Booking", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              )
            ],
          ),
        ],
      ),
    );
  }

  void editBooking() {
    final updatedData  = {
      "serviceNeeded": widget._controllers["serviceNeeded"]?.text,
      "problemDescription": widget._controllers["problemDescription"]?.text,
      "serviceLocation": widget._controllers["serviceLocation"]?.text,
      "serviceDate": widget._selectedDate.toString().substring(0, 10),
    };

    BlocProvider.of<BookingsBloc>(context).add(UpdateBooking(updates: updatedData, bookingId: widget.booking.id, whoUpdated: 'customer', updaterId: widget.customerId));
  }

  void deleteBooking() {
    BlocProvider.of<BookingsBloc>(context).add(DeleteBooking(bookingId:  widget.booking.id, customerId: int.tryParse(widget.customerId)!));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skill_trade/domain/models/booking.dart';
// import 'package:skill_trade/domain/models/technician.dart';
// import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
// import 'package:skill_trade/presentation/widgets/info_label.dart';
// import 'package:skill_trade/application/blocs/bookings_bloc.dart';
// import 'package:skill_trade/presentation/events/bookings_event.dart';

// class CustomerBooking extends StatefulWidget {
//   final Booking booking;
//   final Technician technician;
//   final String customerId;
//   CustomerBooking({super.key, required this.booking, required this.technician, required this.customerId}): 
//     _controllers = {
//       "serviceNeeded": TextEditingController(text: booking.serviceNeeded),
//       "problemDescription": TextEditingController(text: booking.problemDescription),
//       "serviceLocation": TextEditingController(text: booking.serviceLocation),
//     }, 
//     _selectedDate = booking.serviceDate;

//   late DateTime? _selectedDate;
//   final Map<String, TextEditingController> _controllers;

//   @override
//   State<CustomerBooking> createState() => _CustomerBookingState();
// }

// class _CustomerBookingState extends State<CustomerBooking> {

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: widget._selectedDate!,
//       firstDate: DateTime(2010), 
//       lastDate: DateTime(2050), 
//     );
//     if (picked != null && picked != widget._selectedDate) {
//       setState(() {
//         widget._selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.circular(20), 
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               "Booked With",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 15,),
//             Text(
//               widget.technician.name,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 7,),
//             InfoLabel(label: "Email", data: widget.technician.email),
//             SizedBox(height: 7,),
//             InfoLabel(label: "Speciality", data: widget.technician.skills),
//             SizedBox(height: 7,),
//             InfoLabel(label: "Phone", data: widget.technician.phone),
//             SizedBox(height: 20,),

//             InfoLabel(label: "Booked Date", data: widget.booking.bookedDate.toString().substring(0, 10)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Service Date:  ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                     Text(
//                       widget._selectedDate.toString().substring(0, 10),
//                       style: const TextStyle(
//                           fontSize: 15, fontWeight: FontWeight.w500),
//                     ),
//                   ],
                  
//                 ),
//                 TextButton(
//                       onPressed: () => _selectDate(context),
//                       child: const Text('Change Date'),
//                     ),
//               ],
//             ),
//             EditableField(label: "Service Needed", data: widget.booking.serviceNeeded, controller: widget._controllers["serviceNeeded"],),
//             EditableField(label: "Problem Description", data: widget.booking.problemDescription, controller: widget._controllers["problemDescription"],),
//             EditableField(label: "Service Location", data: widget.booking.serviceLocation, controller: widget._controllers["serviceLocation"],),
//             InfoLabel(label: "Status", data: widget.booking.status,),
//             SizedBox(height: 15,),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: editBooking, 
//                   child: Text("Edit", style: TextStyle(color: Colors.white),),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//                 ElevatedButton(
//                   onPressed: deleteBooking, 
//                   child: Text("Delete Booking", style: TextStyle(color: Colors.white),),
//                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void editBooking() {
//     final updatedData  = {
//       "serviceNeeded": widget._controllers["serviceNeeded"]?.text,
//       "problemDescription": widget._controllers["problemDescription"]?.text,
//       "serviceLocation": widget._controllers["serviceLocation"]?.text,
//       "serviceDate": widget._selectedDate.toString().substring(0, 10),
//     };

//     BlocProvider.of<BookingsBloc>(context).add(UpdateBooking(updates: updatedData, bookingId: widget.booking.id, whoUpdated: 'customer', updaterId: widget.customerId));
//   }

//   void deleteBooking() {
//     BlocProvider.of<BookingsBloc>(context).add(DeleteBooking(bookingId:  widget.booking.id, customerId: int.tryParse(widget.customerId)!));
//   }
// }
