import 'package:advance_pdf_viewer_example/main.dart';
import 'package:advance_pdf_viewer_example/screens/video_screen.dart';
import 'package:advance_pdf_viewer_example/screens/player_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  PlayerScreen.routeName: (context) => PlayerScreen(),
  VideoScreen.routeName: (context) => VideoScreen(),
  MyApp.routeName: (context) => MyApp(),
};
