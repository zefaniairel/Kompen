import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Prodi.dart';
import 'package:mobile/notifiers/ProdiNotifier.dart';

final prodiProvider = StateNotifierProvider<ProdiNotifier, List<Prodi>?>((ref) {
  return ProdiNotifier();
});
