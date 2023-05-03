import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image_screen';
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Image'),
      ),
      body: Container(),
    );
  }
}
