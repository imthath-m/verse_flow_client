
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verse_flow_client/viewmodels/media_player_viewmodel.dart';

class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MediaPlayerViewModel>(context);
    return Column(
      children: [
        Text(
          viewModel.surahName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          viewModel.reciterName,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
