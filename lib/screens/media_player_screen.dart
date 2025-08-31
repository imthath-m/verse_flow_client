import 'package:flutter/material.dart';
import 'package:quran_cloud/quran_cloud.dart';
import 'package:verse_flow_client/widgets/media_player_widget.dart';

class MediaPlayerScreen extends StatelessWidget {
  final Surah _surah;

  const MediaPlayerScreen(this._surah, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_surah.englishName)),
      body: const MediaPlayerWidget(),
    );
  }
}
