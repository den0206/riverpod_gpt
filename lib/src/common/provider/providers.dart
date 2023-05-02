import 'package:dart_openai/openai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/app_router.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen_model.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen_state.dart';
import 'package:riverpod_gpt/src/service/chat_list_notifier.dart';
import 'package:riverpod_gpt/src/service/models_notifier.dart';

class SettingsProviders {
  static final routeProvider = Provider<AppRouter>((ref) {
    return AppRouter(ref);
  });

  static final modelProvider =
      NotifierProvider<ModelsNotifier, OpenAIModelModel?>(
    ModelsNotifier.new,
  );

  static final chatListProvider = AutoDisposeNotifierProvider<ChatListNotifier,
      List<OpenAIChatCompletionChoiceMessageModel>>(
    () => ChatListNotifier(),
  );
}

class ViewModelProviders {
  static final chatViewProvider =
      AutoDisposeNotifierProvider<ChatScreenModel, ChatScreenState>(
    () => ChatScreenModel(),
  );
}
