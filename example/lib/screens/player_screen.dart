// @dart=2.9
import 'package:advance_pdf_viewer_example/main.dart';
import 'package:advance_pdf_viewer_example/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'commons/player_buttons.dart';
import 'commons/playlist.dart';

class PlayerScreen extends StatefulWidget {
  static String routeName = "/player";

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class AudioMetadata {
  final String title;
  final String artwork;

  AudioMetadata({this.title, this.artwork});
}

class _PlayerScreenState extends State<PlayerScreen> {
  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(('asset:///assets/audio/lotusblume.mp3')),
            tag: AudioMetadata(
              title: "Geistige Praktik Lotus-Blume",
              artwork:
                  "https://allatra-book.org/uploads/thumbs/publication/850x0_04663b18b360a1ae0636d6cf27304bc6.jpg",
            ),
          ),
          AudioSource.uri(
            Uri.parse(('asset:///assets/audio/allatra.mp3')),
            tag: AudioMetadata(
              title: "Kurzfassung vom Buch AllatRa",
              artwork:
                  "https://allatra-book.org/uploads/thumbs/publication/850x0_496d90b7156af1710335afc96f765567.jpg",
            ),
          ),
          AudioSource.uri(
            Uri.parse(('asset:///assets/audio/sensishambalIII.mp3')),
            tag: AudioMetadata(
              title: "Sensei von Shambala Buch Ⅲ S1/49",
              artwork:
                  "https://allatra-book.org/uploads/thumbs/publication/145x0_d6ed7e88b4a853fe2a992ae3b7b7fbc5.jpg",
            ),
          ),
          AudioSource.uri(
            Uri.parse(('asset:///assets/audio/powerfullmusic.mp3')),
            tag: AudioMetadata(
              title: "Dialog mit Gott - Meditations Musik",
              artwork:
                  "https://allatra-book.org/uploads/thumbs/publication/145x0_3fffdd5872a81b7e0059667ca54ba487.jpg",
            ),
          ),
        ],
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AllatRa - Hörbücher - Media Center'),
        backgroundColor: Colors.indigo.shade400,
      ), //backgroundColor: Colors.lime.shade50,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: Playlist(_audioPlayer)),
              PlayerButtons(_audioPlayer),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              Navigator.popAndPushNamed(context, VideoScreen.routeName);
            });
          },
          icon: Icon(Icons.video_library),
          label: Text("Top Videos"),
          elevation: 5.0,
        );
      }),
    );
  }
}
