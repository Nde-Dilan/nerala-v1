import 'package:flutter/material.dart';

// Main StatefulWidget for the Progress Page
class ProgressPage extends StatefulWidget {
  final String selectedLanguage; // Language selected by the user
  
  const ProgressPage({
    Key? key, 
    this.selectedLanguage = 'French' // Default language is French
  }) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  String currentLevel = 'Level 1'; // Initial level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 255, 230), // Light green background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () => Navigator.pop(context), // Navigate back on press
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4), // Margin to the right
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular shape
              color: Colors.transparent, // Transparent background
            ),
            width: 80,
            height: 80,
            child: Image.asset('assets/logo.png'), // inserting image
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 230, 255, 230), // Light green background
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(color: Colors.black), // Icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the level panel
          children: [
            Text(
              widget.selectedLanguage, // Display selected language
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3), // Spacing
            SizedBox(
              width: 120,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 247, 202, 69)), // Border color
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                  color: Colors.white, // White background for dropdown
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6), // Padding inside the container
                child: DropdownButton<String>(
                  value: currentLevel, // Current selected level
                  isExpanded: true, // Expand to full width
                  underline: Container(), // Remove underline
                  items: ['Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5']
                      .map((String level) => DropdownMenuItem(
                            value: level,
                            child: Text(level), // Dropdown item text
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      currentLevel = value!; // Update current level
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24), // Spacing
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 4, 224, 0), // Text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Calender',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600], // Text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18), // Spacing
            Expanded(
              child: ListView(
                children: const [
                  ProgressItem(title: 'Grammar', progress: 3, total: 5),
                  ProgressItem(title: 'Reading', progress: 2, total: 5),
                  ProgressItem(title: 'Pronunciation', progress: 2, total: 5),
                  ProgressItem(title: 'Hand writing', progress: 5, total: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// StatelessWidget for individual progress items
class ProgressItem extends StatelessWidget {
  final String title; // Title of the progress item
  final int progress; // Current progress
  final int total; // Total progress

  const ProgressItem({
    Key? key,
    required this.title,
    required this.progress,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Vertical margin
      padding: const EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 255, 218, 84)), // Border color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        color: Colors.white, // White background for progress items
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // Title text
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12), // Spacing
          Row(
            children: List.generate(
              total,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8.0), // Spacing between icons
                child: Icon(
                  index < progress ? Icons.check_circle : Icons.circle_outlined, // Icon based on progress
                  color: index < progress ? const Color.fromARGB(255, 67, 220, 73) : Colors.grey.shade300, // Icon color
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
