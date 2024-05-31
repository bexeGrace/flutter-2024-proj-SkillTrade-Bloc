import 'package:flutter_test/flutter_test.dart';
import 'package:skill_trade/presentation/screens/technician_profile.dart';
import 'package:skill_trade/presentation/widgets/technician_booking_list.dart';
import 'package:skill_trade/presentation/screens/technician.dart';

void main() {
  group('TechnicianPageLogic Unit Tests', () {
    test('Initial selected index is 0', () {
      final logic = TechnicianPageLogic();
      expect(logic.selectedIndex, 0);
    });

    test('navigateBottomBar sets selected index correctly', () {
      final logic = TechnicianPageLogic();

      // Simulate navigation to index 1
      logic.navigateBottomBar(1);
      expect(logic.selectedIndex, 1);

      // Simulate navigation back to index 0
      logic.navigateBottomBar(0);
      expect(logic.selectedIndex, 0);
    });

    test('Correct page is returned for each selected index', () {
      final logic = TechnicianPageLogic();

      logic.navigateBottomBar(0);
      var currentPage = logic.getCurrentPage();
      expect(currentPage, isA<TechnicianBookingList>());

      logic.navigateBottomBar(1);
      currentPage = logic.getCurrentPage();
      expect(currentPage, isA<TechnicianProfile>());
    });
  });
}
