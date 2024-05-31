import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
import 'editable_textfield_widget_test.mocks.dart';

@GenerateMocks([ReviewsBloc])
void main() {
  late MockReviewsBloc mockReviewsBloc;

  setUp(() {
    mockReviewsBloc = MockReviewsBloc();
    when(mockReviewsBloc.stream).thenAnswer((_) => Stream.empty());
  });

  testWidgets('EditableField displays correctly and handles editing', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController(text: "Initial Data");

    await tester.pumpWidget(
      BlocProvider<ReviewsBloc>.value(
        value: mockReviewsBloc,
        child: MaterialApp(
          home: Scaffold(
            body: EditableField(
              label: "Label",
              data: "Initial Data",
              controller: controller,
            ),
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.text("Label"), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Initial Data"), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);

    // Tap edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verify edit mode
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text("Initial Data"), findsOneWidget);

    // Enter new text
    await tester.enterText(find.byType(TextField), "Updated Data");
    await tester.pumpAndSettle();

    // Tap check button to save changes
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    // Verify view mode
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.text("Updated Data"), findsOneWidget);
  });

  testWidgets('EditableField dispatches UpdateReview event when editing review', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController(text: "Initial Review");
    final String label = "review,1,123";

    await tester.pumpWidget(
      BlocProvider<ReviewsBloc>.value(
        value: mockReviewsBloc,
        child: MaterialApp(
          home: Scaffold(
            body: EditableField(
              label: label,
              data: "Initial Review",
              controller: controller,
            ),
          ),
        ),
      ),
    );

    // Tap edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Enter new review text
    await tester.enterText(find.byType(TextField), "Updated Review");
    await tester.pumpAndSettle();

    // Tap check button to save changes
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    // Verify UpdateReview event is added to the bloc
    verify(mockReviewsBloc.add(UpdateReview(
      reviewId: 1,
      updates: {"review": "Updated Review"},
      technicianId: 123,
    ))).called(1);
  });
}
