import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    try {
      await _audioPlayer.setAsset('sound1.wav'); // Replace with the path to your audio file
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void _playAudio() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _playAudio();
      },
      child: const Text(''),
    );
  }
}
