import 'package:flutter/material.dart';

class AnimatedPriceButton extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;
  final String price;

  const AnimatedPriceButton({
    super.key,
    required this.isEnabled,
    this.onPressed,
    required this.price,
  });

  @override
  State<AnimatedPriceButton> createState() => _AnimatedPriceButtonState();
}

class _AnimatedPriceButtonState extends State<AnimatedPriceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFF7ED957),
                Color(0xFF93FF69),
              ],
              stops: [
                _animation.value,
                _animation.value + 0.5,
              ],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              // borderRadius: BorderRadius.circular(15),
              onTap: widget.isEnabled ? widget.onPressed : null,
              child: Center(
                child: Text(
                  "PAY ${widget.price} XAF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
