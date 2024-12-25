import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Dashboard.dart';
import 'package:mobile/notifiers/DashboardNotifier.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, Dashboard?>((ref) {
  return DashboardNotifier();
});
