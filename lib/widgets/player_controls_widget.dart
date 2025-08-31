import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verse_flow_client/viewmodels/media_player_viewmodel.dart';

class PlayerControlsWidget extends StatelessWidget {
  const PlayerControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MediaPlayerViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Icon(Icons.replay_10),
        // const SizedBox(width: 16),
        IconButton(
          icon: Icon(
            viewModel.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 96,
          ),
          onPressed: () => viewModel.togglePlayPause(),
        ),
        // const SizedBox(width: 16),
        // const Icon(Icons.forward_10),
      ],
    );
  }
}
