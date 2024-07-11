import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  Future<void> _initializeVideoPlayer() async {
    if (widget.videoLink.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.videoLink)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: Colors.blue,
      ),
      body: widget.videoLink.isEmpty
          ? Center(
              child: Text(
                'No Video link in this lecture.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          : _controller != null && _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : const Center(child: CircularProgressIndicator()),
      floatingActionButton: widget.videoLink.isNotEmpty
          ? FloatingActionButton(
              onPressed: _controller != null && _controller!.value.isPlaying
                  ? _controller!.pause
                  : _controller!.play,
              child: Icon(
                _controller != null && _controller!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
