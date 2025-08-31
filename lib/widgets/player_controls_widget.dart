import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verse_flow_client/viewmodels/media_player_viewmodel.dart';

class PlayerControlsWidget extends StatelessWidget {
  const PlayerControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MediaPlayerViewModel>(context);
    final playOrResume = viewModel.state == MediaPlayerState.paused
        ? viewModel.resume
        : viewModel.play;
    final playButton = _buildControlButton(Icons.play_arrow, playOrResume);
    final pauseButton = _buildControlButton(Icons.pause, viewModel.pause);
    final stopButton = _buildControlButton(Icons.stop, viewModel.stop);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Icon(Icons.replay_10),
        // const SizedBox(width: 16),
        switch (viewModel.state) {
          MediaPlayerState.playing => pauseButton,
          MediaPlayerState.paused => playButton,
          MediaPlayerState.stopped => playButton,
        },
        if (viewModel.state != MediaPlayerState.stopped) ...[
          const SizedBox(width: 16),
          stopButton,
        ],
        // const SizedBox(width: 16),
        // const Icon(Icons.forward_10),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon, size: 96), onPressed: onPressed);
  }
}
