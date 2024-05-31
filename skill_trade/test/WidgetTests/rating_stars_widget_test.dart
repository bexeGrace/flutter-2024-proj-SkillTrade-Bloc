import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/rating_stars.dart';

void main() {
  group('RatingStars Widget Tests', () {
    testWidgets('Displays the correct number of filled stars for rating 0', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 0),
        ),
      ));
      
      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.orange), findsNothing);
    });

    testWidgets('Displays the correct number of filled stars for rating 1', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 1),
        ),
      ));
      
      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.orange), findsNWidgets(1));
    });

    testWidgets('Displays the correct number of filled stars for rating 3', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 3),
        ),
      ));
      
      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.orange), findsNWidgets(3));
    });

    testWidgets('Displays the correct number of filled stars for rating 5', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 5),
        ),
      ));
      
      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.orange), findsNWidgets(5));
    });

    testWidgets('Displays grey stars for rating 0', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 0),
        ),
      ));
      
      // Assert
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.grey), findsNWidgets(5));
    });

    testWidgets('Displays grey stars for rating 2', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 2),
        ),
      ));
      
      // Assert
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.grey), findsNWidgets(3));
    });

    testWidgets('Displays grey stars for rating 4', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RatingStars(rating: 4),
        ),
      ));
      
      // Assert
      expect(find.byWidgetPredicate((widget) => widget is Icon && widget.color == Colors.grey), findsNWidgets(1));
    });
  });
}
