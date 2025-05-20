import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_mobile.dart';
import 'package:mockapp/res/components/CustomGradientButton.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  late VideoPlayerController _videoController;
  int _currentPage = 0;

  final _pages = [
    {
      'type': 'video',
      'asset': 'lib/assets/videos/onboarding_car_video.mp4',
      'title': 'Hiltermann Lease Group.',
      'subtitle':
          'We are an independent leasing company, focused on SMEs in the Netherlands.',
    },
    {
      'type': 'image',
      'asset': 'lib/assets/images/hiltermann_onboarding_screen.png',
      'title': 'Flexible Solutions.',
      'subtitle':
          'From cars to equipment — we make leasing simple and accessible.',
    },
  ];

  @override
  void initState() {
    super.initState();

    // initialize video controller (for page 0)
    _videoController = VideoPlayerController.asset(_pages[0]['asset'] as String)
      ..initialize().then((_) {
        _videoController
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _pages[_currentPage];

    return Scaffold(
      body: Stack(
        children: [
          // 1) Background: Video or Image
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              itemBuilder: (_, index) {
                final page = _pages[index];
                if (page['type'] == 'video' &&
                    _videoController.value.isInitialized) {
                  // make the video cover the full screen
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  );
                } else if (page['type'] == 'image') {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        page['asset'] as String,
                        fit: BoxFit.cover,
                        alignment: Alignment(0.5, 0.5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0B1423), // #0B1423 color
                              Colors.transparent, // Transparent color
                            ],
                            stops: [0.1958, 0.4444],
                            // Corresponds to 19.58% and 44.44% in CSS
                            begin: Alignment.topCenter,
                            // Gradient starts from the top
                            end: Alignment
                                .bottomCenter, // Gradient ends at the bottom
                          ),
                        ),
                      ),
                    ],
                  );
                }
                // fallback while video is initializing
                return Container(color: Colors.black);
              },
            ),
          ),

          // 2) Dark overlay for legibility
          // Positioned.fill(
          //   child: Container(color: Colors.black.withOpacity(0.5)),
          // ),

          // 3) Foreground UI
          Positioned.fill(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // top text + indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          current['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          current['subtitle'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: _pages.length,
                          effect: WormEffect(
                            dotColor: Colors.white30,
                            activeDotColor: Colors.white,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // spacer so button is at bottom
                  const Spacer(),

                  // “Get Started” button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomGradientButton(
                      title: 'Get Started',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginMobile(),
                          ),
                        );
                      },
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
