import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen.dart';

class ImageScreen extends ConsumerWidget {
  static const routeName = '/image_screen';
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(ViewModelProviders.imageViewProvider.notifier);
    final state = ref.watch(ViewModelProviders.imageViewProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Generate Image'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TextFileldArea(
                controller: vm.imageTextController,
                focusNode: vm.focusNode,
                onSubmit: () async => await vm.generateImage(),
              ),
              if (state.isLoading) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
              const SizedBox(
                height: 35,
              ),
              if (state.imageData != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    height: 300,
                    width: 300,
                    state.imageData!.data.first.url!,
                  ),
                )
              ]
            ],
          ),
        ));
  }
}
