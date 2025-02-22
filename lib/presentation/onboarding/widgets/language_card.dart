import 'package:flutter/material.dart';
import 'package:other_screens/data/models/onboarding/language_model.dart';

class LanguageCard extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onInfoTap;

  const LanguageCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onSelect,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          color:
              isSelected ? Colors.black.withValues(alpha: 0.05) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  language.flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      language.region,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onInfoTap,
                icon: const CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.black54,
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
