import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();





  @override
  Future<void> onStart() async {
    _player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playbackState.add(playbackState.value.copyWith(
          controls: [MediaControl.play],
          playing: false,
          updatePosition: Duration.zero,  // Update position using updatePosition
        ));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: _player.playing
              ? [MediaControl.pause]
              : [MediaControl.play],
          playing: _player.playing,
          updatePosition: _player.position,  // Correct usage of updatePosition
        ));
      }
    });



  }

  Future<void> loadUrl(String url) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      print("Error loading URL: $e");
    }
  }


  @override
  Future<void> onPlay() async {
    await _player.play();
    playbackState.add(playbackState.value.copyWith(playing: true, updatePosition: _player.position));
  }

  @override
  Future<void> onPause() async {
    await _player.pause();
    playbackState.add(playbackState.value.copyWith(playing: false, updatePosition: _player.position));
  }

  @override
  Future<void> onStop() async {
    await _player.stop();
    playbackState.add(playbackState.value.copyWith(playing: false, updatePosition: Duration.zero));
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    await _player.seek(position);
  }
}
