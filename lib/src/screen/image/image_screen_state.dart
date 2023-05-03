import 'package:dart_openai/openai.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/src/screen/image/image_screen_state.freezed.dart';

@freezed
class ImageScreenState with _$ImageScreenState {
  const factory ImageScreenState({
    @Default(false) bool isLoading,
    @Default(null) OpenAIImageModel? imageData,
  }) = _ImageScreenState;
}
