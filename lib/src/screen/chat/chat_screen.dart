import 'package:flutter/material.dart';
import 'package:riverpod_gpt/src/_generated/gen/assets.gen.dart';
import 'package:riverpod_gpt/src/_generated/gen/colors.gen.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

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
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Text("SAMPLE");
              },
            )),
            Material(
              color: ColorName.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(),
                        onSubmitted: (value) async {},
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can I help you",
                            hintStyle: TextStyle(color: Colors.grey)),
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
