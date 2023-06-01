//NOT IN USE
import 'dart:async';
import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Fetch the mp4 data from the API and create a VideoPlayerController
    _fetchVideo().then((controller) {
      setState(() {
        _controller = controller;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<VideoPlayerController> _fetchVideo() async {
    // Make the HTTP request to the API to get the mp4 data
    var httpClient = HttpClient();
    var request =
        await httpClient.getUrl(Uri.parse("http://my-api.com/video.mp4"));
    var response = await request.close();

    // Create a byte stream from the response
    var byteStream = response.asBroadcastStream();

    // Create a Uint8List from the stream of bytes
    var bytes = byteStream.expand((data) => data);

// Use the 'await' keyword to wait for the Future to complete
    var uint8List = Uint8List.fromList(await bytes.toList());

    final blob = html.Blob([uint8List]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    return VideoPlayerController.network(url);
    // Use the Uint8List to create a new VideoPlayerController
    //return VideoPlayerController.asset(uint8List);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Use the VideoPlayer widget to display the video
          child: _controller != null
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }
}
