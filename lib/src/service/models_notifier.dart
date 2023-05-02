import 'package:dart_openai/openai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelsNotifier extends Notifier<OpenAIModelModel?> {
  @override
  build() {
    return null;
  }

  Future<void> setModel(OpenAIModelModel model) async {
    state = model;
  }
}
