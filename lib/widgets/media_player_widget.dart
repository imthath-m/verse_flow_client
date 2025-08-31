
import 'package:flutter/material.dart';
import 'package:verse_flow_client/widgets/player_controls_widget.dart';
import 'package:verse_flow_client/widgets/player_progress_widget.dart';
import 'package:verse_flow_client/widgets/surah_info_widget.dart';

class MediaPlayerWidget extends StatelessWidget {
  const MediaPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SurahInfoWidget(),
        SizedBox(height: 32),
        PlayerControlsWidget(),
        SizedBox(height: 32),
        PlayerProgressWidget(),
      ],
    );
  }
}
