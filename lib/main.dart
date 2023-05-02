import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/service/openai_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiKey = dotenv.get("OPENAI_KEY");
  OpenAI.apiKey = apiKey;

  final client = OpenAIClient();

  // await client.sendMessage(
  //     "日本 新宿周辺のおいしいご飯屋さんを {'name':hogehoge,'reason'':hogehoge,'url'': https://hogehoge.com/,'image_url':https://hogehoge.com/ } のような形で5軒ください。返答に JSON 以外の文章は入れないでください。",
  //     []);

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
