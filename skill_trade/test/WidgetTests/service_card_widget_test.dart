import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/services_card.dart';

void main() {
  group('ServicesCard Widget Tests', () {
    testWidgets('Displays the title correctly', (WidgetTester tester) async {
      // Arrange
      const title = 'Service Title';
      const description = 'Service Description';
      const imageUrl = 'assets/technician.png'; // Make sure this image is available in your assets

      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ServicesCard(
            title: title,
            description: description,
            imageUrl: imageUrl,
          ),
        ),
      ));
      
      // Assert
      expect(find.text(title), findsOneWidget);
    });

    testWidgets('Displays the description correctly', (WidgetTester tester) async {
      // Arrange
      const title = 'Service Title';
      const description = 'Service Description';
      const imageUrl = 'assets/technician.png'; // Make sure this image is available in your assets

      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ServicesCard(
            title: title,
            description: description,
            imageUrl: imageUrl,
          ),
        ),
      ));
      
      // Assert
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('Displays the image correctly', (WidgetTester tester) async {
      // Arrange
      const title = 'Service Title';
      const description = 'Service Description';
      const imageUrl = 'assets/technician.png'; // Make sure this image is available in your assets

      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ServicesCard(
            title: title,
            description: description,
            imageUrl: imageUrl,
          ),
        ),
      ));
      
      // Assert
      expect(find.byType(Image), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == imageUrl), findsOneWidget);
    });

    testWidgets('Card has correct margin and padding', (WidgetTester tester) async {
      // Arrange
      const title = 'Service Title';
      const description = 'Service Description';
      const imageUrl = 'assets/technician.png'; // Make sure this image is available in your assets

      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ServicesCard(
            title: title,
            description: description,
            imageUrl: imageUrl,
          ),
        ),
      ));

      // Assert
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.margin, EdgeInsets.only(left: 10, right: 10));
      
      final paddingFinder = find.descendant(
        of: find.byType(Card),
        matching: find.byType(Padding),
      );

      final paddingWidgets = tester.widgetList<Padding>(paddingFinder).toList();
      expect(paddingWidgets.any((padding) => padding.padding == EdgeInsets.all(8.0)), isTrue);
    });
  });
}
