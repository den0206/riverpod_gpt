import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/screen/image/image_screen_state.dart';
import 'package:riverpod_gpt/src/service/openai_client.dart';

class ImageScreenModel extends AutoDisposeNotifier<ImageScreenState> {
  @override
  ImageScreenState build() {
    ref.onDispose(() {
      onDispose();
    });

    focusNode.requestFocus();
    return const ImageScreenState();
  }

  final imageTextController = TextEditingController();
  final focusNode = FocusNode();
  bool get isLoading => state.isLoading;

  final _gptClient = OpenAIClient();

  void onDispose() {
    imageTextController.dispose();
    focusNode.dispose();
  }

  Future<void> generateImage() async {
    if (imageTextController.text.isEmpty || state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final prompt = imageTextController.text;

    imageTextController.clear();
    focusNode.unfocus();
    try {
      final image = await _gptClient.generateImage(prompt: prompt);

      state = state.copyWith(imageData: image);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
