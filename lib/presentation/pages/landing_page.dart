import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/music/source/audio_service.dart';
import 'package:other_screens/presentation/auth/pages/login_page.dart';
import 'package:other_screens/presentation/auth/pages/register_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

//TODO: Reduce the duration and size of that song

class _LandingPageState extends State<LandingPage> {
  late AudioService _audioService;

  @override
  void initState() {
    super.initState();
    _audioService = AudioService();
    // _initAudioAsync();
  }

  Future<void> _initAudioAsync() async {
    try {
      // Ensure initialization happens on main thread
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize audio in background
      Future.microtask(() async {
        await _audioService.initialize();
        await _audioService.play();
      });
    } catch (e) {
      debugPrint('Audio initialization error: $e');
    }
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            spacing: 14,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: scaffoldBgColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/one-bar.png"),
                        const SizedBox(
                          height: 19,
                        ),
                        Image.asset("assets/icons/bubble.png"),
                        Image.asset("assets/logo.png"),
                        const Text(
                          "N E R A L A",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 38.0),
                          child: const Text(
                            "Learn Languages whenever and wherever you want. ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              NextButton(
                onPressed: () {
                  // Navigate to "Get Started" screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                isEnabled: true,
                text: 'GET STARTED',
              ),
              NextButton(
                onPressed: () {
                  // Navigate to "LOG IN" screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                isEnabled: true,
                text: 'LOG IN',
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final bool? isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const NextButton({
    super.key,
    this.isEnabled,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(mediaWidth(context) / 0.9, mediaWidth(context) / 6),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        //disabledBackgroundColor: Colors.grey,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
