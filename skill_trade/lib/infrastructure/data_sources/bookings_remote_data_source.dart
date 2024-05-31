import 'package:skill_trade/domain/models/booking.dart';

abstract class IBookingsRemoteDataSource {
  Future<List<Booking>> fetchCustomerBookings(String customerId, String token, String endpoint);
  Future<List<Booking>> fetchTechnicianBookings(String technicianId, String token, String endpoint);
  Future<void> postBooking(Booking booking, String token, String endpoint);
  Future<void> updateBooking(String bookingId, Map<String, dynamic> updates, String token, String endpoint);
  Future<void> deleteBooking(String bookingId, String token, String endpoint);
}
