import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/service/openai_client.dart';

class ChatListNotifier
    extends AutoDisposeNotifier<List<OpenAIChatCompletionChoiceMessageModel>> {
  @override
  List<OpenAIChatCompletionChoiceMessageModel> build() {
    return [
      const OpenAIChatCompletionChoiceMessageModel(
          content: "Hello", role: OpenAIChatMessageRole.assistant)
    ];
  }

  final _gptClient = OpenAIClient();

  Future<void> sendMessage({required String message}) async {
    try {
      final newUserMessage = OpenAIChatCompletionChoiceMessageModel(
        content: message,
        role: OpenAIChatMessageRole.user,
      );
      state = [...state, newUserMessage];

      final assistantMessage = await _gptClient.sendMessage(message, state);

      state = [...state, assistantMessage];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void clearMessages() {
    state = [];
  }
}
