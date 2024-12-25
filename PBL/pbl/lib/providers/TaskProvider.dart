import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Task.dart';
import 'package:mobile/notifiers/TaskNotifier.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task?>>((ref) {
  return TaskNotifier();
});
