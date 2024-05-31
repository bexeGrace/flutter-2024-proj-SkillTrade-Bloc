import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:skill_trade/application/blocs/individual_technician_bloc.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/individual_technician_event.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/screens/admin_technician.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/domain/models/review.dart';
import 'package:skill_trade/presentation/states/individual_technician_state.dart';
import 'package:skill_trade/presentation/states/review_state.dart';
import 'package:skill_trade/presentation/widgets/rating_stars.dart';
import 'package:skill_trade/presentation/widgets/technician_profile.dart';

class MockIndividualTechnicianBloc
    extends MockBloc<IndividualTechnicianEvent, IndividualTechnicianState>
    implements IndividualTechnicianBloc {}

class MockReviewsBloc extends MockBloc<ReviewsEvent, ReviewsState>
    implements ReviewsBloc {}

void main() {
  late MockIndividualTechnicianBloc mockIndividualTechnicianBloc;
  late MockReviewsBloc mockReviewsBloc;

  setUp(() {
    mockIndividualTechnicianBloc = MockIndividualTechnicianBloc();
    mockReviewsBloc = MockReviewsBloc();
  });

  // testWidgets('AdminTechnician widget test', (WidgetTester tester) async {
  //   final technician = Technician(
  //     id: 1,
  //     name: 'John Doe',
  //     email: 'john.doe@example.com',
  //     phone: " 098888",
  //     status: 'accepted',
  //     skills: 'dish sra',
  //     experience: '3year',
  //     education_level: 'degree',
  //     available_location: 'addis abab',
  //     additional_bio: 'bio',
  //   );

  //   final reviews = [
  //     Review(
  //         customer: 'Alice',
  //         rating: 4,
  //         comment: 'Great service!',
  //         customerId: 1,
  //         id: 2),
  //     Review(
  //         customer: 'Bob',
  //         rating: 5,
  //         comment: 'Excellent work!',
  //         customerId: 1,
  //         id: 1),
  //   ];

  //   // Set up mock bloc states
  //   whenListen(
  //     mockIndividualTechnicianBloc,
  //     Stream.fromIterable([IndividualTechnicianLoaded(technician: technician)]),
  //     initialState: IndividualTechnicianLoading(),
  //   );

  //   whenListen(
  //     mockReviewsBloc,
  //     Stream.fromIterable([ReviewsLoaded(reviews)]),
  //     initialState: ReviewsLoading(),
  //   );

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: MultiBlocProvider(
  //         providers: [
  //           BlocProvider<IndividualTechnicianBloc>(
  //             create: (_) => mockIndividualTechnicianBloc,
  //           ),
  //           BlocProvider<ReviewsBloc>(
  //             create: (_) => mockReviewsBloc,
  //           ),
  //         ],
  //         child: const AdminTechnician(technicianId: 1),
  //       ),
  //     ),
  //   );

  //   await tester.pumpAndSettle(); // Ensure the widget tree is fully built

  //   // Verify AppBar title
  //   expect(find.text('Technician'), findsOneWidget);

  //   // Verify Technician profile is displayed
  //   expect(find.byType(TechnicianSmallProfile), findsOneWidget);
  //   expect(find.text('John Doe'), findsOneWidget);
  //   expect(find.text('john.doe@example.com'), findsOneWidget);
  //   // expect(find.text('098888'), findsOneWidget);

  //   // Verify buttons for technician status
  //   expect(find.text('Suspend'), findsOneWidget);
  //   expect(find.text('Unsuspend'), findsOneWidget);

  //   // Verify reviews section
  //   expect(find.text('Reviews'), findsOneWidget);
  //   expect(find.byType(RatingStars), findsNWidgets(2)); // Two reviews
  //   expect(find.text('Alice'), findsOneWidget);
  //   expect(find.text('Great service!'), findsOneWidget);
  //   expect(find.text('Bob'), findsOneWidget);
  //   expect(find.text('Excellent work!'), findsOneWidget);
  // });
}
