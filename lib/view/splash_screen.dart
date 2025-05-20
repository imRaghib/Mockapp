import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mockapp/utils/routes/routes_names.dart';

class SplashVideoScreen extends StatefulWidget {
  const SplashVideoScreen({super.key});

  @override
  State<SplashVideoScreen> createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset('lib/assets/videos/splash_screen.mp4')
          ..initialize().then((_) {
            setState(() {});
            _controller.play();

            // Wait until the video ends
            _controller.addListener(() {
              if (_controller.value.position >= _controller.value.duration) {
                Navigator.pushReplacementNamed(context, RoutesNames.login);
              }
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
