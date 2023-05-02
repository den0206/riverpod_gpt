import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_gpt/src/_generated/gen/assets.gen.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';
import 'package:riverpod_gpt/src/common/provider/providers.dart';

class ChatScreen extends ConsumerWidget {
  static const routeName = '/chat';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ViewModelProviders.chatViewProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.icon.icon.path),
        ),
        title: const Text('GPT'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ChatArea(),
            const Spacer(),
            if (state.isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            // const ModelDropdownButtons(),
            const TextFileldArea(),
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
    final state = ref.watch(SettingsProviders.chatListProvider);
    return Expanded(
      child: ListView.builder(
        itemCount: state.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final message = state[index];
          final bool isAssistant =
              message.role == OpenAIChatMessageRole.assistant;
          return Material(
            color: isAssistant
                ? ColorName.scaffoldBackgroundColor
                : ColorName.cardColor,
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
                            fontSize: 16),
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
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextFileldArea extends ConsumerWidget {
  const TextFileldArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(ViewModelProviders.chatViewProvider.notifier);

    return Material(
      color: ColorName.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: vm.textfield,
                decoration: const InputDecoration.collapsed(
                    hintText: "How can I help you",
                    hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) async {
                  await vm.sendMessage();
                },
              ),
            ),
            IconButton(
                onPressed: () async {
                  vm.sendMessage();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
