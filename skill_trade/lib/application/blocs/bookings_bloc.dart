import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/domain/repositories/bookings_repository.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/presentation/states/bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final IBookingsRepository bookingsRepository;

  BookingsBloc({required this.bookingsRepository}) : super(BookingsLoading()) {
    on<LoadCustomerBookings>(_onLoadCustomerBookings);
    on<LoadTechnicianBookings>(_onLoadTechnicianBookings);
    on<PostBooking>(_onPostBookings);
    on<UpdateBooking>(_onUpdateBooking);
    on<DeleteBooking>(_onDeleteBooking);
  }

  Future<void> _onLoadCustomerBookings(LoadCustomerBookings event, Emitter<BookingsState> emit) async {
    emit(BookingsLoading());
    try {
      final bookings = await bookingsRepository.getCustomerBookings(event.customerId);
      emit(BookingsLoaded(bookings));
    } catch (error) {
      emit(BookingsError(error.toString()));
    }
  }

  Future<void> _onLoadTechnicianBookings(LoadTechnicianBookings event, Emitter<BookingsState> emit) async {
    emit(BookingsLoading());
    try {
      final bookings = await bookingsRepository.getTechnicianBookings(event.technicianId);
      emit(BookingsLoaded(bookings));
    } catch (error) {
      emit(BookingsError(error.toString()));
    }
  }

  Future<void> _onPostBookings(PostBooking event, Emitter<BookingsState> emit) async {
    try {
      final booking = Booking(
        id: 0,
        customerId: event.customerId!,
        technicianId: event.technicianId,
        serviceNeeded: event.serviceNeeded,
        serviceLocation: event.serviceLocation,
        serviceDate: event.serviceDate,
        problemDescription: event.problemDescription, 
        bookedDate: DateTime.now(),
        status: "pending",
      );
      await bookingsRepository.createBooking(booking);
      add(LoadCustomerBookings(customerId: event.customerId.toString()));
    } catch (error) {
      emit(BookingsError(error.toString()));
    }
  }

  Future<void> _onUpdateBooking(UpdateBooking event, Emitter<BookingsState> emit) async {
    try {
      await bookingsRepository.updateBooking(event.bookingId.toString(), event.updates);
      if (event.whoUpdated == "technician") {
        add(LoadTechnicianBookings(technicianId: event.updaterId));
      } else {
        add(LoadCustomerBookings(customerId: event.updaterId));
      }
    } catch (error) {
      emit(BookingsError(error.toString()));
    }
  }

  Future<void> _onDeleteBooking(DeleteBooking event, Emitter<BookingsState> emit) async {
    try {
      await bookingsRepository.deleteBooking(event.bookingId.toString());
      add(LoadCustomerBookings(customerId: event.customerId.toString()));
    } catch (error) {
      emit(BookingsError(error.toString()));
    }
  }
}
