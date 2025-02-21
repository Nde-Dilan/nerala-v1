import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:other_screens/common/constants.dart';
import 'package:provider/provider.dart';

class TextToSpeechButton extends StatefulWidget {
  final String word;
  final String missingWord;
  const TextToSpeechButton(
      {super.key, required this.word, this.missingWord = ""});

  @override
  State<TextToSpeechButton> createState() => _TextToSpeechButtonState();
}

class _TextToSpeechButtonState extends State<TextToSpeechButton> {
  bool _isTapped = false;

  late FlutterTts _flutterTts;

  @override
  void initState() {
    _flutterTts = FlutterTts();
    Future.delayed(const Duration(milliseconds: 500), () {
      _setUpTTS();
    });
    super.initState();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
          onPressed: () {
            _runTts(text: widget.word);
            setState(() {
              _isTapped = !_isTapped;
            });
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _isTapped = !_isTapped;
              });
            });
          },
          icon: Icon(
            Icons.volume_up,
            size: 30,
            color: _isTapped ? disabledColor : seedColor,
          )),
    );
  }

  void _setUpTTS() async {
    await _flutterTts.setLanguage(languageCode);

    // _flutterTts.getLanguages.then((languages) {
    //   print("languages: $languages");
    // });

    await _flutterTts.setSpeechRate(0.4);
  }

  _runTts({required String text}) async {
    // Replace "___" with [missingWord] if found, otherwise keep original text
    final String processedText = text.contains("___")
        ? text.replaceAll("___", widget.missingWord)
        : text;

    await _flutterTts.speak(processedText);
  }
}
