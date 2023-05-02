import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen_state.dart';

class ChatScreenModel extends AutoDisposeNotifier<ChatScreenState> {
  @override
  ChatScreenState build() {
    return const ChatScreenState();
  }

  final textfield = TextEditingController();
  final _focusNode = FocusNode();

  void onDispose() {
    _focusNode.dispose();
  }

  Future<void> sendMessage() async {
    if (textfield.text.isEmpty) return;

    try {
      state = state.copyWith(isTyping: true);
      final action = ref.read(SettingsProviders.chatListProvider.notifier);

      await action.sendMessage(message: textfield.text);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      state = state.copyWith(isTyping: false);
    }
  }
}
