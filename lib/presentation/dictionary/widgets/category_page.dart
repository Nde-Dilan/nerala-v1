import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CategoryTabs({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab("Words", 0),
        _buildTab("Phrases", 1),
        _buildTab("History", 2),
      ],
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.brown : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Container(
              height: 2,
              color: isSelected ? Colors.brown : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
