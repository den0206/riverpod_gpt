import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/screen/image/image_screen_state.dart';
import 'package:riverpod_gpt/src/service/openai_client.dart';

class ImageScreenModel extends AutoDisposeNotifier<ImageScreenState> {
  @override
  ImageScreenState build() {
    return const ImageScreenState();
  }

  bool get isLoading => state.isLoading;

  final _gptClient = OpenAIClient();

  Future<void> generateImage({required String prompt}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

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
