import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/notifiers/AuthNotifier.dart';

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);