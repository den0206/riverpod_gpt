import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/service/openai_client.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(child: ModelDropdownButtons()),
    );
  }
}

class ModelDropdownButtons extends ConsumerWidget {
  const ModelDropdownButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiClient = OpenAIClient();

    final currentModel = ref.watch(SettingsProviders.modelProvider);

    return FutureBuilder<List<OpenAIModelModel>>(
      future: aiClient.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const FittedBox(
            child: SpinKitFadingCircle(
              color: Colors.lightBlue,
              size: 30,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton<OpenAIModelModel>(
                  dropdownColor: ColorName.scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<OpenAIModelModel>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index],
                      child: Text(
                        snapshot.data![index].id,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  value: currentModel,
                  onChanged: (value) async {
                    if (value == null) return;
                    await ref
                        .read(SettingsProviders.modelProvider.notifier)
                        .setModel(value);
                  },
                ),
              );
      },
    );
  }
}
