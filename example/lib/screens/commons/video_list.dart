import 'package:advance_pdf_viewer_example/routes.dart';
import 'package:advance_pdf_viewer_example/screens/player_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List<YoutubePlayerController> _controllers = [
    'FXelf4YMNfw', // Das Lukas Evangelium - Film/Doku
    'rv7hW7dEBx4', // Wovon die Propheten träumten
    'YxWLiNraTkI', // In frieden mit sich selbst - Daniel Ganser
    'H20Ao1GUvWE', // Energetische Konstruktion des Menschen in der unsichtbaren Welt. Ursprüngliches Wissen
    'R-sRaT_A0P0', // SubPersönlichkeit oder Engel - Die Wahl
    'Kyf85-yi7GI', // ATLANTIS. ELITE AUF DER SUCHE NACH UNSTERBLICHKEIT
    'VrrwDTorNm0', // Es Kommt - Klimaveränderung
  ]
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E SPIRITUAL - Top Videos'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            actionsPadding: const EdgeInsets.only(left: 16.0),
            bottomActions: [
              CurrentPosition(),
              const SizedBox(width: 10.0),
              ProgressBar(isExpanded: true),
              const SizedBox(width: 10.0),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: _controllers.length,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              Navigator.pop(context, PlayerScreen.routeName);
            });
          },
          icon: Icon(Icons.multitrack_audio),
          label: Text("zurück"),
          elevation: 8.0,
        );
      }),
    );
  }
}
