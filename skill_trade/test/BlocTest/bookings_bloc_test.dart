import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/models/booking.dart';
import 'package:skill_trade/domain/repositories/bookings_repository.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/presentation/states/bookings_state.dart';

import 'bookings_bloc_test.mocks.dart';

@GenerateMocks([IBookingsRepository])
void main() {
  late MockIBookingsRepository mockBookingsRepository;
  late BookingsBloc bookingsBloc;

  setUp(() {
    mockBookingsRepository = MockIBookingsRepository();
  });

  tearDown(() {
    bookingsBloc.close();
  });

  group('BookingsBloc', () {
    final booking = Booking(
      id: 1,
      customerId: 1,
      technicianId: 1,
      serviceNeeded: 'repair',
      serviceLocation: 'location',
      serviceDate: DateTime.now(),
      problemDescription: 'problem',
      bookedDate: DateTime.now(),
      status: 'pending',
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsLoaded] when LoadCustomerBookings event is added',
      setUp: () {
        when(mockBookingsRepository.getCustomerBookings('1')).thenAnswer((_) async => [booking]);
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(LoadCustomerBookings(customerId: '1')),
      expect: () => [BookingsLoading(), BookingsLoaded([booking])],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsLoaded] when LoadTechnicianBookings event is added',
      setUp: () {
        when(mockBookingsRepository.getTechnicianBookings('1')).thenAnswer((_) async => [booking]);
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicianBookings(technicianId: '1')),
      expect: () => [BookingsLoading(), BookingsLoaded([booking])],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsError] when LoadCustomerBookings event is added and an error occurs',
      setUp: () {
        when(mockBookingsRepository.getCustomerBookings('1')).thenThrow(Exception('Failed to load bookings'));
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(LoadCustomerBookings(customerId: '1')),
      expect: () => [BookingsLoading(), BookingsError('Exception: Failed to load bookings')],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsError] when LoadTechnicianBookings event is added and an error occurs',
      setUp: () {
        when(mockBookingsRepository.getTechnicianBookings('1')).thenThrow(Exception('Failed to load bookings'));
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicianBookings(technicianId: '1')),
      expect: () => [BookingsLoading(), BookingsError('Exception: Failed to load bookings')],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsLoaded] when PostBooking event is added and booking is created successfully',
      setUp: () {
        when(mockBookingsRepository.createBooking(any)).thenAnswer((_) async => Future.value());
        when(mockBookingsRepository.getCustomerBookings('1')).thenAnswer((_) async => [booking]);
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(PostBooking(
        customerId: 1,
        technicianId: 1,
        serviceNeeded: 'repair',
        serviceLocation: 'location',
        serviceDate: DateTime.now(),
        problemDescription: 'problem',
      )),
      expect: () => [BookingsLoading(), BookingsLoaded([booking])],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsError] when PostBooking event is added and an error occurs',
      setUp: () {
        when(mockBookingsRepository.createBooking(any)).thenThrow(Exception('Failed to create booking'));
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(PostBooking(
        customerId: 1,
        technicianId: 1,
        serviceNeeded: 'repair',
        serviceLocation: 'location',
        serviceDate: DateTime.now(),
        problemDescription: 'problem',
      )),
      expect: () => [BookingsError('Exception: Failed to create booking')],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsLoaded] when UpdateBooking event is added and booking is updated successfully',
      setUp: () {
        when(mockBookingsRepository.updateBooking(any, any)).thenAnswer((_) async => Future.value());
        when(mockBookingsRepository.getCustomerBookings('1')).thenAnswer((_) async => [booking]);
        when(mockBookingsRepository.getTechnicianBookings('1')).thenAnswer((_) async => [booking]);
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(UpdateBooking(
        bookingId: 1,
        updates: {'status': 'completed'},
        whoUpdated: 'customer',
        updaterId: '1',
      )),
      expect: () => [BookingsLoading(), BookingsLoaded([booking])],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsError] when UpdateBooking event is added and an error occurs',
      setUp: () {
        when(mockBookingsRepository.updateBooking(any, any)).thenThrow(Exception('Failed to update booking'));
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(UpdateBooking(
        bookingId: 1,
        updates: {'status': 'completed'},
        whoUpdated: 'customer',
        updaterId: '1',
      )),
      expect: () => [BookingsError('Exception: Failed to update booking')],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsLoaded] when DeleteBooking event is added and booking is deleted successfully',
      setUp: () {
        when(mockBookingsRepository.deleteBooking('1')).thenAnswer((_) async => Future.value());
        when(mockBookingsRepository.getCustomerBookings('1')).thenAnswer((_) async => []);
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(DeleteBooking(bookingId: 1, customerId: 1)),
      expect: () => [BookingsLoading(), BookingsLoaded([])],
    );

    blocTest<BookingsBloc, BookingsState>(
      'emits [BookingsLoading, BookingsError] when DeleteBooking event is added and an error occurs',
      setUp: () {
        when(mockBookingsRepository.deleteBooking('1')).thenThrow(Exception('Failed to delete booking'));
      },
      build: () {
        bookingsBloc = BookingsBloc(bookingsRepository: mockBookingsRepository);
        return bookingsBloc;
      },
      act: (bloc) => bloc.add(DeleteBooking(bookingId: 1, customerId: 1)),
      expect: () => [BookingsError('Exception: Failed to delete booking')],
    );
  });
}
