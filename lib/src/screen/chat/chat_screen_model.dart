import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen_state.dart';

class ChatScreenModel extends AutoDisposeNotifier<ChatScreenState> {
  @override
  ChatScreenState build() {
    ref.onDispose(() {
      onDispose();
    });
    return const ChatScreenState();
  }

  final textfield = TextEditingController();
  final listScrollController = ScrollController();
  final focusNode = FocusNode();

  void onDispose() {
    textfield.dispose();
    listScrollController.dispose();
    focusNode.dispose();
  }

  void _scrollListToEND() {
    listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  void clearChat() {
    ref.read(SettingsProviders.chatListProvider.notifier).clearMessages();
  }

  Future<void> sendMessage() async {
    if (textfield.text.isEmpty || state.isTyping) return;

    final message = textfield.text;

    focusNode.unfocus();
    textfield.clear();

    try {
      state = state.copyWith(isTyping: true);
      final action = ref.read(SettingsProviders.chatListProvider.notifier);

      await action.sendMessage(message: message);

      _scrollListToEND();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      state = state.copyWith(isTyping: false);
    }
  }
}
