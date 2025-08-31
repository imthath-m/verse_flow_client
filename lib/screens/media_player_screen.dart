
import 'package:flutter/material.dart';
import 'package:verse_flow_client/widgets/media_player_widget.dart';

class MediaPlayerScreen extends StatelessWidget {
  const MediaPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player'),
      ),
      body: const MediaPlayerWidget(),
    );
  }
}
