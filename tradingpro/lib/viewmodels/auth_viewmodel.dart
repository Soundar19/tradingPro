import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = Provider((ref) => AuthService());

final userProvider = StateProvider((ref) => null);
