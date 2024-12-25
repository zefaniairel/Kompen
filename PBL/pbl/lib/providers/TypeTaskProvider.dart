import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/TypeTask.dart';
import 'package:mobile/notifiers/TypeTaskNotifier.dart';

final typeTaskProvider =
    StateNotifierProvider<TypeTaskNotifier, List<TypeTask>?>((ref) {
  return TypeTaskNotifier();
});
