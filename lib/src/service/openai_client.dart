import 'package:dart_openai/openai.dart';

class OpenAIClient {
  final _openAI = OpenAI.instance;

  Future<List<OpenAIModelModel>> getAllModels() async {
    List<OpenAIModelModel> models = await _openAI.model.list();

    return models;
  }

  Future<OpenAIChatCompletionChoiceMessageModel> sendMessage(String message,
      List<OpenAIChatCompletionChoiceMessageModel> messages) async {
    List<OpenAIChatCompletionChoiceMessageModel> currentMessage = [];
    // メッセージをuserロールでモデル化
    final newUserMessage = OpenAIChatCompletionChoiceMessageModel(
      content: message,
      role: OpenAIChatMessageRole.user,
    );
    // メッセージを追加
    currentMessage = [
      ...messages,
      newUserMessage,
    ];
    // ChatGPTに聞く
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      // これまでのやりとりを含めて送信
      messages: currentMessage,
    );

    // 結果を追加
    currentMessage = [
      ...currentMessage,
      chatCompletion.choices.first.message,
    ];

    return chatCompletion.choices.first.message;
  }

  Future<OpenAIImageModel> generateImage({required String prompt}) async {
    final OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: prompt,
      n: 1,
      size: OpenAIImageSize.size512,
      responseFormat: OpenAIImageResponseFormat.url,
    );

    return image;
  }
}
