import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> sendMessage() async {}
}
