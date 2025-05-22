// import 'package:flutter/foundation.dart';
//
// class DashboardViewModel extends ChangeNotifier {
//   late CreditLimitModel _creditLimitModel;
//
//   DashboardViewModel() {
//     _creditLimitModel = CreditLimitModel(
//       approvedLimit: 1000000,
//       availableLimit: 31465.70,
//       utilizedLimit: 968543.30,
//       floorPlanUnits: 23,
//       floorPlanUnitsStatus: 'Registered',
//     );
//   }
//
//   // Getters to expose the model properties
//   double get approvedLimit => _creditLimitModel.approvedLimit;
//
//   double get availableLimit => _creditLimitModel.availableLimit;
//
//   double get utilizedLimit => _creditLimitModel.utilizedLimit;
//
//   int get floorPlanUnits => _creditLimitModel.floorPlanUnits;
//
//   String get floorPlanUnitsStatus => _creditLimitModel.floorPlanUnitsStatus;
//
//   // Business logic
//   double calculateNormalized() => 1 - (availableLimit / approvedLimit);
//
// // Add any setters or update methods here if data can change and notifyListeners();
// }
