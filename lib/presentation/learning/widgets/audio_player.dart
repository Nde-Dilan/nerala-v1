import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/presentation/learning/widgets/question_header.dart';

class AudioPlayer extends StatefulWidget {
  final String url;
  final Color primaryColor;
  final Color backgroundColor;
  final double height;

  const AudioPlayer({
    super.key,
    required this.url,
    this.primaryColor = const Color(0xFF4CAF50),
    this.backgroundColor = const Color(0xFFE8F5E9),
    this.height = 56.0,
  });

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  bool _isPlaying = false;
  double _progress = 0.0;

  void _togglePlay() {
    // Here you would implement actual audio playing logic
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        // Simulate progress for demonstration
        // _startProgressSimulation();
      }
    });
  }

  void _startProgressSimulation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isPlaying && mounted) {
        setState(() {
          _progress += 0.01;
          if (_progress >= 1.0) {
            _progress = 0.0;
            _isPlaying = false;
          } else {
            _startProgressSimulation();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _togglePlay();
      },
      highlightColor: scaffoldBgColor,
      focusColor: scaffoldBgColor,
      hoverColor: scaffoldBgColor,
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Click to listen',
                style: AppTextStyles.h3,
              ),
            ),
            IconButton(
              highlightColor: scaffoldBgColor,
              icon: Image.asset(
                "assets/icons/question-type/listen-speak/voice.png",
              ),
              onPressed: _togglePlay,
            ),
          ],
        ),
      ),
    );
  }
}
