import 'package:skill_trade/domain/models/booking.dart';

abstract class IBookingsRepository {
  Future<List<Booking>> getCustomerBookings(String customerId);
  Future<List<Booking>> getTechnicianBookings(String technicianId);
  Future<void> createBooking(Booking booking);
  Future<void> updateBooking(String bookingId, Map<String, dynamic> updates);
  Future<void> deleteBooking(String bookingId);
}
