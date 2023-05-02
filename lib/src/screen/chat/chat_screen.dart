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
    final vm = ref.watch(ViewModelProviders.chatViewProvider.notifier);
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
            const Spacer(),
            if (state.isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            // const ModelDropdownButtons(),
            Material(
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
                        onSubmitted: (value) async {},
                      ),
                    ),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
