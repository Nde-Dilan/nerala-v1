import 'package:flutter/material.dart';
import 'package:other_screens/data/models/main/dictionary_model.dart';
import 'package:other_screens/presentation/dictionary/widgets/category_page.dart';
import '../widgets/dictionary_card.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "My dictionary",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.local_activity_outlined,
              size: 28,
             // color: Colors.brown,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Text(
              "Every word learned is a step toward fluency! 🌟",
              style: TextStyle(
                fontSize: 19,
               // color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          CategoryTabs(
            selectedIndex: _selectedTabIndex,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: DictionaryEntry.sampleEntries.length,
              itemBuilder: (context, index) {
                return DictionaryCard(
                  entry: DictionaryEntry.sampleEntries[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}