import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/app_router.dart';

class SettingsProviders {
  static final routeProvider = Provider<AppRouter>((ref) {
    return AppRouter(ref);
  });
}
