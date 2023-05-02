import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/src/screen/chat/chat_screen_state.freezed.dart';
part '../../_generated/src/screen/chat/chat_screen_state.g.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  const factory ChatScreenState({
    @Default(false) bool isTyping,
  }) = _ChatScreenState;
  factory ChatScreenState.fromJson(Map<String, dynamic> json) =>
      _$ChatScreenStateFromJson(json);
}
