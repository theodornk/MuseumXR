import 'dart:async';
import 'dart:convert';
//import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mr_museum/screens/headset_dashboard.dart';
import 'package:mr_museum/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mr_museum/services/custom_video_player.dart';

final GlobalKey videoPlayerKey = GlobalKey();

class StreamTest extends StatefulWidget {
  const StreamTest({super.key});

  @override
  State<StreamTest> createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
  VideoPlayerController? _controller; //Fjernet null
  Future<void>? videoPlayerFuture;

  getVideo4() async {}
  @override
  void initState() {
    super.initState();
    //_controller = VideoPlayerController.network('https://127.0.0.1:5000/stream')
    //  ..initialize().then((_) {
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {
    //      _controller?.play();
    //   });
    // });
    //getVideo();
    //getVideo3();
    /*String username = 'teklab';
    String password = 'mac123456';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    var response = http.get(
      Uri.parse("https://158.37.237.213/api/holographic/stream/live_low.mp4"),
      headers: {'authorization': basicAuth},
    ).then((value) {
      print('hællæ');
      final blob = html.Blob([value.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      _controller = VideoPlayerController.network(url);
      print('helloyo');

      setState(() {
        //
        videoPlayerFuture = _controller!.initialize(); //La inn i setstate
      });

      _controller!.play();
    });*/
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: ((() => Navigator.of(context).pop())),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text('Livestream'),
          ),
          body: Center(
            child: CustomVideoPlayer(),
          ) /*FutureBuilder(
            future: videoPlayerFuture,
            builder: (context, snapshot) {
              if (true) {
                print('connection state done');
                return AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),*/
          ),
    );
  }
}
