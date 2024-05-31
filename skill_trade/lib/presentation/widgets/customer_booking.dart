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

  const CustomerBooking({
    super.key,
    required this.booking,
    required this.technician,
    required this.customerId,
  });

  @override
  State<CustomerBooking> createState() => _CustomerBookingState();
}

class _CustomerBookingState extends State<CustomerBooking> {
  late DateTime? _selectedDate;
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.booking.serviceDate;
    _controllers = {
      "serviceNeeded":
          TextEditingController(text: widget.booking.serviceNeeded),
      "problemDescription":
          TextEditingController(text: widget.booking.problemDescription),
      "serviceLocation":
          TextEditingController(text: widget.booking.serviceLocation),
    };
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void editBooking() {
    final updatedData = {
      "serviceNeeded": _controllers["serviceNeeded"]?.text,
      "problemDescription": _controllers["problemDescription"]?.text,
      "serviceLocation": _controllers["serviceLocation"]?.text,
      "serviceDate": _selectedDate.toString().substring(0, 10),
    };

    BlocProvider.of<BookingsBloc>(context).add(UpdateBooking(
      updates: updatedData,
      bookingId: widget.booking.id,
      whoUpdated: 'customer',
      updaterId: widget.customerId,
    ));
  }

  void deleteBooking() {
    BlocProvider.of<BookingsBloc>(context).add(DeleteBooking(
      bookingId: widget.booking.id,
      customerId: int.tryParse(widget.customerId)!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Booked With",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          Text(
            widget.technician.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 7),
          InfoLabel(label: "Email", data: widget.technician.email),
          const SizedBox(height: 7),
          InfoLabel(label: "Speciality", data: widget.technician.skills),
          const SizedBox(height: 7),
          InfoLabel(label: "Phone", data: widget.technician.phone),
          const SizedBox(height: 20),
          InfoLabel(
              label: "Booked Date",
              data: widget.booking.bookedDate.toString().substring(0, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Service Date:  ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    _selectedDate.toString().substring(0, 10),
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
          EditableField(
              label: "Service Needed",
              data: widget.booking.serviceNeeded,
              controller: _controllers["serviceNeeded"]),
          EditableField(
              label: "Problem Description",
              data: widget.booking.problemDescription,
              controller: _controllers["problemDescription"]),
          EditableField(
              label: "Service Location",
              data: widget.booking.serviceLocation,
              controller: _controllers["serviceLocation"]),
          InfoLabel(label: "Status", data: widget.booking.status),
          const SizedBox(height: 15),
          Row(
            children: [
              ElevatedButton(
                onPressed: editBooking,
                child:
                    const Text("Edit", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: deleteBooking,
                child: const Text("Delete Booking",
                    style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
