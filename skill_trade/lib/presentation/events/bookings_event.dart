import 'package:equatable/equatable.dart';

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomerBookings extends BookingsEvent {
  final String customerId;

  const LoadCustomerBookings({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

class LoadTechnicianBookings extends BookingsEvent {
  final String technicianId;

  const LoadTechnicianBookings({required this.technicianId});

  @override
  List<Object?> get props => [technicianId];
}

class PostBooking extends BookingsEvent {
  final int? customerId;
  final int technicianId;
  final String serviceNeeded;
  final DateTime serviceDate;
  final String serviceLocation;
  final String problemDescription;

  const PostBooking({
    required this.problemDescription,
    required this.customerId,
    required this.technicianId,
    required this.serviceNeeded,
    required this.serviceDate,
    required this.serviceLocation,
  });

  @override
  List<Object?> get props => [
        customerId,
        technicianId,
        serviceNeeded,
        serviceDate,
        serviceLocation,
        problemDescription,
      ];
}

class UpdateBooking extends BookingsEvent {
  final Map<String, dynamic> updates;
  final int bookingId;
  final String whoUpdated;
  final String updaterId;

  const UpdateBooking({
    required this.updates,
    required this.bookingId,
    required this.whoUpdated,
    required this.updaterId,
  });

  @override
  List<Object?> get props => [
        updates,
        bookingId,
        whoUpdated,
        updaterId,
      ];
}

class DeleteBooking extends BookingsEvent {
  final int bookingId;
  final int customerId;

  const DeleteBooking({
    required this.bookingId,
    required this.customerId,
  });

  @override
  List<Object?> get props => [bookingId, customerId];
}
