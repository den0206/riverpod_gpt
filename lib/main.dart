import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(SettingsProviders.routeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorName.scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(color: ColorName.cardColor),
      ),
      initialRoute: router.initialRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
