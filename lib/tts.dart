import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Text2Speech extends StatefulWidget {
  const Text2Speech({super.key, required this.textToSpeak});

  final String textToSpeak;

  @override
  State<Text2Speech> createState() => _Text2SpeechState();
}

class _Text2SpeechState extends State<Text2Speech> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _speak() async {
    await _flutterTts.speak(widget.textToSpeak);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _speak,
          child: const Text('Speak'),
        ),
      ],
    );
  }
}
