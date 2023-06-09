import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_gpt/src/_generated/gen/assets.gen.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';
import 'package:riverpod_gpt/src/screen/image/image_screen.dart';

class ChatScreen extends ConsumerWidget {
  static const routeName = '/chat';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(ViewModelProviders.chatViewProvider.notifier);
    final state = ref.watch(ViewModelProviders.chatViewProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.images.chatLogo.path),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () {
              vm.focusNode.unfocus();
              Navigator.of(context).pushNamed(ImageScreen.routeName);
            },
          ),
          IconButton(
            icon: const Icon(Icons.restore_from_trash),
            onPressed: () {
              vm.clearChat();
            },
          ),
        ],
        title: const Text('GPT'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ChatArea(),

            if (state.isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              )
            ],

            // const ModelDropdownButtons(),
            TextFileldArea(
              controller: vm.textfield,
              focusNode: vm.focusNode,
              onSubmit: () async => await vm.sendMessage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatArea extends ConsumerWidget {
  const ChatArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(ViewModelProviders.chatViewProvider.notifier);
    final chatList = ref.watch(SettingsProviders.chatListProvider);
    return Expanded(
      child: ListView.builder(
        itemCount: chatList.length,
        controller: vm.listScrollController,
        itemBuilder: (context, index) {
          final message = chatList[index];

          return ChatCell(message: message);
        },
      ),
    );
  }
}

class ChatCell extends StatelessWidget {
  const ChatCell({
    super.key,
    required this.message,
  });

  final OpenAIChatCompletionChoiceMessageModel message;

  @override
  Widget build(BuildContext context) {
    final bool isAssistant = message.role == OpenAIChatMessageRole.assistant;

    return Material(
      color:
          isAssistant ? ColorName.scaffoldBackgroundColor : ColorName.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              isAssistant
                  ? Assets.images.chatLogo.path
                  : Assets.images.person.path,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            if (isAssistant) ...[
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 100),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText(
                        message.content.trim(),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Text(
                message.content,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class TextFileldArea extends StatelessWidget {
  const TextFileldArea({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorName.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration.collapsed(
                    hintText: "How can I help you",
                    hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) async {
                  if (onSubmit != null) onSubmit!();
                },
              ),
            ),
            IconButton(
              onPressed: onSubmit,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
