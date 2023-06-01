import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';

class CustomVideoPlayer extends StatefulWidget {
  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  html.VideoElement? _videoElement;

  @override
  void initState() {
    super.initState();

    _videoElement = html.VideoElement()
      ..autoplay = true
      ..controls = true;
    _videoElement!.setAttribute('crossorigin', 'anonymous');
    final hlsSupported =
        _videoElement!.canPlayType('application/vnd.apple.mpegurl') != '';

    if (hlsSupported) {
      _videoElement!.src = 'https://127.0.0.1:5000/stream.m3u8';
      print('Video source URL: ${_videoElement!.src}');
      print('lalalala');
    } else {
      final hls = js.JsObject(js.context['Hls']);

      //if (hls.hasProperty('isSupported') && hls.callMethod('isSupported', [])) {
      final hlsInstance = js.JsObject(hls['constructor']);
      hlsInstance
          .callMethod('loadSource', ['https://127.0.0.1:5000/stream.m3u8']);
      hlsInstance.callMethod('attachMedia', [_videoElement]);

      //print('Using Hls.js to handle the HLS stream');
      //} else {
      //print('Hls.js is not supported in this browser');
      //}
    }
    // Register the video element with Flutter's PlatformViewRegistry
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'videoElement',
      (int viewId) => _videoElement!,
    );
  }

  @override
  void dispose() {
    //_videoElement!.pause();
    //_videoElement!.load();
    _videoElement?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      viewType: 'videoElement',
    );
  }
}
