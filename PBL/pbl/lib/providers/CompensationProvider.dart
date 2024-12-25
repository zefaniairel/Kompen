import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/notifiers/CompensationNotifier.dart';
import 'package:mobile/models/Compensation.dart';

final compensationProvider =
    StateNotifierProvider<CompensationNotifier, List<Compensation>>((ref) {
  return CompensationNotifier();
});
