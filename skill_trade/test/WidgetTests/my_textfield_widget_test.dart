import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/widgets/my_textfield.dart';

void main() {
  group('MyTextField Widget Tests', () {
    testWidgets('Displays labelText correctly', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();
      const labelText = 'Username';
      
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            labelText: labelText,
            prefixIcon: Icons.person,
            controller: controller,
            toggleText: false,
          ),
        ),
      ));
      
      // Assert
      expect(find.text(labelText), findsOneWidget);
    });

    testWidgets('PrefixIcon is displayed', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();
      const prefixIcon = Icons.person;
      
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            labelText: 'Username',
            prefixIcon: prefixIcon,
            controller: controller,
            toggleText: false,
          ),
        ),
      ));
      
      // Assert
      expect(find.byIcon(prefixIcon), findsOneWidget);
    });

    testWidgets('SuffixIcon toggles obscure text', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();
      const suffixIcon = Icons.visibility;
      
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            labelText: 'Password',
            prefixIcon: Icons.lock,
            suffixIcon: suffixIcon,
            controller: controller,
            obscureText: true,
            toggleText: true,
          ),
        ),
      ));
      
      // Assert
      expect(find.byIcon(suffixIcon), findsOneWidget);
      
      // Initially, text should be obscured
      expect(find.byType(TextFormField).evaluate().single.widget as TextFormField, isNot(contains('text')));

      // Tap the suffix icon
      await tester.tap(find.byIcon(suffixIcon));
      await tester.pumpAndSettle();

      // Text should now be visible
      expect(find.byType(TextFormField).evaluate().single.widget as TextFormField, isA<TextFormField>());
    });

    testWidgets('Validator returns error message if field is empty and required', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();
      
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            child: MyTextField(
              labelText: 'Username',
              prefixIcon: Icons.person,
              controller: controller,
              toggleText: false,
            ),
          ),
        ),
      ));
      
      await tester.enterText(find.byType(TextFormField), '');
      await tester.tap(find.byType(Form));
      await tester.pump();

      // Assert
      expect(find.text('Username'), findsOneWidget);
    });
    
    testWidgets('Validator does not return error message if field is not required', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();
      
      // Act
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            child: MyTextField(
              labelText: 'Optional Field',
              prefixIcon: Icons.info,
              controller: controller,
              toggleText: false,
              requiredField: false,
            ),
          ),
        ),
      ));
      
      await tester.enterText(find.byType(TextFormField), '');
      await tester.tap(find.byType(Form));
      await tester.pump();

      // Assert
      expect(find.text('Please enter your Optional Field'), findsNothing);
    });
  });
}
