import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_gpt/src/screen/chat/chat_screen.dart';
import 'package:riverpod_gpt/src/screen/home/home_screen.dart';

class AppRouter {
  final Ref ref;

  final initialRoute = ChatScreen.routeName;

  AppRouter(this.ref);

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case ChatScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Center(
            child: Text("Undefined"),
          ),
        );
    }
  }
}
