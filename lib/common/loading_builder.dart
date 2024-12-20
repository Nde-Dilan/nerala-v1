import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './constants.dart';

class DefaultLoadingBuilder extends StatelessWidget {
  const DefaultLoadingBuilder({super.key, this.primaryColor = seedColor, this.secondaryColor});
  final Color? primaryColor, secondaryColor;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.flickr(
      leftDotColor: secondaryColor ?? seedColorPalette.shade200,
      rightDotColor: primaryColor ?? seedColor,
      size: 50.0,
    );
  }
}