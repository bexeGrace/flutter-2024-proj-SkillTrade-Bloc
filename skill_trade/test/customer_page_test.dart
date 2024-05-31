import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/screens/customer.dart';
import 'package:skill_trade/presentation/screens/customer_profile.dart';
import 'package:skill_trade/presentation/screens/customer_bookings.dart';
import 'package:skill_trade/presentation/screens/find_technicians.dart';

void main() {
  group('CustomerPageLogic Unit Tests', () {
    test('Initial selected index is 0', () {
      final logic = CustomerPageLogic();
      expect(logic.selectedIndex, 0);
    });

    test('navigateBottomBar sets selected index correctly', () {
      final logic = CustomerPageLogic();

      // Simulate navigation to index 1
      logic.navigateBottomBar(1);
      expect(logic.selectedIndex, 1);

      // Simulate navigation to index 2
      logic.navigateBottomBar(2);
      expect(logic.selectedIndex, 2);
    });

    test('Correct page is returned for each selected index', () {
      final logic = CustomerPageLogic();

      logic.navigateBottomBar(0);
      var currentPage = logic.getCurrentPage();
      expect(currentPage, isA<FindTechnician>());

      logic.navigateBottomBar(1);
      currentPage = logic.getCurrentPage();
      expect(currentPage, isA<CustomerBookings>());

      logic.navigateBottomBar(2);
      currentPage = logic.getCurrentPage();
      expect(currentPage, isA<CustomerProfileScreen>());
    });
  });
}
