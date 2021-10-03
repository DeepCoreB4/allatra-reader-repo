// @dart=2.9
// playlist.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Playlist extends StatefulWidget {
  const Playlist(this._audioPlayer, {Key key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState>(
      stream: widget._audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state?.sequence ?? [];
        return ListView(
          children: [
            const Image(
              image: NetworkImage(
                  'https://media.giphy.com/media/7PK51oAq6EcUnrQYmW/giphy-downsized.gif?cid=790b7611585685bc52c96fef07c7020db7a9ef2b811356aa&rid=giphy-downsized.gif&ct=g'),
            ),
            SizedBox(
              height: 35,
            ), // Abstandhalter
            for (var i = 0; i < sequence.length; i++)
              ListTile(
                selected: i == state.currentIndex,
                leading: Image.network(sequence[i].tag.artwork),
                title: Text(sequence[i].tag.title),
                onTap: () {
                  widget._audioPlayer.seek(Duration.zero, index: i);
                },
              ),
          ],
        );
      },
    );
  }
}
