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

  Future<void> _reset() async {
    await _flutterTts.stop();
  }

  Future<void> _pause() async {
    await _flutterTts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _speak,
          child: const Text('用語音說故事'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: _reset,
          child: const Text('重置語音'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: _pause,
          child: const Text('暫停語音'),
        ),
      ],
    );
  }
}
