
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verse_flow_client/viewmodels/media_player_viewmodel.dart';

class PlayerProgressWidget extends StatelessWidget {
  const PlayerProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MediaPlayerViewModel>(context);
    return Column(
      children: [
        Slider(
          value: viewModel.progress,
          onChanged: (value) => viewModel.setProgress(value),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('1:23'),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text('3:45'),
            ),
          ],
        ),
      ],
    );
  }
}
