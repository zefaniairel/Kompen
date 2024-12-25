import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Competence.dart';
import 'package:mobile/notifiers/CompetenceNotifier.dart';

final competenceProvider = StateNotifierProvider<CompetenceNotifier, List<Competence>?>((ref) {
  return CompetenceNotifier();
});
