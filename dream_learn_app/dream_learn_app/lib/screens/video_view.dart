import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class OnlineVideoView extends StatefulWidget {
  final String videoLink;
  const OnlineVideoView({required this.videoLink, super.key});

  @override
  State<OnlineVideoView> createState() => _OnlineVideoViewState();
}

class _OnlineVideoViewState extends State<OnlineVideoView> {
    VideoPlayerController? _controller;
  File? _videoFile;

  _getFirebaseVideoFile()async{
        final url=  await FirebaseStorage.instance
  .ref()
  .child("videos/1717561300821jd.mp4")
  .getDownloadURL();



//  _videoFile = await DefaultCacheManager().getSingleFile(url);
setState(() {
  
});
 _controller = VideoPlayerController.networkUrl (Uri.parse(widget.videoLink))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


  @override
  void initState() {
    
   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: _controller!=null? VideoPlayer(_controller!): const Center(child: CircularProgressIndicator()),
    );
  }
}