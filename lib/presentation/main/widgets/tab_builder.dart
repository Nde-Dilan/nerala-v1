import 'package:flutter/material.dart';

class TabBuilder extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String title;

  const TabBuilder({super.key, 
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 48.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 8.0),
          Text(title),
        ],
      ),
    );
  }
}