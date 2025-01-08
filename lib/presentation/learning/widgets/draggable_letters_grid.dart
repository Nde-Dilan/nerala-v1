import 'package:flutter/material.dart';
import 'package:other_screens/data/learning/models/question.dart';
import 'package:other_screens/presentation/learning/widgets/choice_card.dart';

class DraggableLettersGrid extends StatefulWidget {
  final List<String> letters;
  final Function(String) onWordBuilt;
  final int maxWordLength;

  const DraggableLettersGrid({
    super.key,
    required this.letters,
    required this.onWordBuilt,
    this.maxWordLength = 8,
  });

  @override
  State<DraggableLettersGrid> createState() => _DraggableLettersGridState();
}

class _DraggableLettersGridState extends State<DraggableLettersGrid> {
  final List<String> _selectedLetters = [];
  final List<bool> _usedLetters = [];

  @override
  void initState() {
    super.initState();
    _usedLetters.addAll(List.generate(widget.letters.length, (_) => false));
  }

  void _submitWord() {
    if (_selectedLetters.isNotEmpty) {
      final word = _selectedLetters.join();
      widget.onWordBuilt(word);
      setState(() {
        _selectedLetters.clear();
        _usedLetters.fillRange(0, _usedLetters.length, false);
      });
    }
  }

  void _resetSelection() {
    setState(() {
      _selectedLetters.clear();
      _usedLetters.fillRange(0, _usedLetters.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Word display area
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  _selectedLetters.join(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (_selectedLetters.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.backspace_outlined),
                  onPressed: () {
                    setState(() {
                      if (_selectedLetters.isNotEmpty) {
                        final lastIndex = _selectedLetters.length - 1;
                        _selectedLetters.removeLast();
                        // Find the last used letter and mark it as unused
                        for (int i = _usedLetters.length - 1; i >= 0; i--) {
                          if (_usedLetters[i]) {
                            _usedLetters[i] = false;
                            break;
                          }
                        }
                      }
                    });
                  },
                ),
            ],
          ),
        ),

        // Letters grid
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(
            widget.letters.length,
            (index) => GestureDetector(
              onTap: _usedLetters[index] ||
                      _selectedLetters.length >= widget.maxWordLength
                  ? null
                  : () {
                      setState(() {
                        _selectedLetters.add(widget.letters[index]);
                        _usedLetters[index] = true;
                      });
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _usedLetters[index]
                      ? Colors.grey.shade300
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.letters[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _usedLetters[index]
                          ? Colors.grey.shade600
                          : Colors.blue.shade900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _selectedLetters.isEmpty ? null : _resetSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _selectedLetters.isEmpty ? null : _submitWord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade50,
                  foregroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Example usage
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Choice cards grid
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            ChoiceCard(
              choice: Choice(
                value: 'dog',
                label: 'Dog',
                imageUrl: 'dog_image_url',
                backgroundColor: Colors.blue.shade50,
              ),
              onTap: () {},
            ),
            // Add more choice cards...
          ],
        ),

        // Draggable letters grid
        Padding(
          padding: const EdgeInsets.all(16),
          child: DraggableLettersGrid(
            letters: ['G', 'R', 'A', 'D', 'U', 'A', 'T', 'I', 'O', 'N'],
            onWordBuilt: (word) {
              debugPrint('Built word: $word');
            },
          ),
        ),
      ],
    );
  }
}
