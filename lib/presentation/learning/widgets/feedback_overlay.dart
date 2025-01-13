import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class FeedbackOverlay extends StatefulWidget {
  final bool isCorrect;
  final VoidCallback? onDismissed;
  final Duration displayDuration;
  final Duration animationDuration;

  const FeedbackOverlay({
    super.key,
    required this.isCorrect,
    this.onDismissed,
    this.displayDuration = const Duration(seconds: 2),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<FeedbackOverlay> createState() => _FeedbackOverlayState();
}

class _FeedbackOverlayState extends State<FeedbackOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward().then((_) {
      Future.delayed(widget.displayDuration, () {
        if (mounted) {
          _controller.reverse().then((_) {
            widget.onDismissed?.call();
          });
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.isCorrect ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isCorrect ? Icons.check : Icons.close,
                  color: white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.isCorrect ? 'Correct!' : 'Not quite right!',
                style: const TextStyle(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!widget.isCorrect)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'You can revise it in the revise section!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
