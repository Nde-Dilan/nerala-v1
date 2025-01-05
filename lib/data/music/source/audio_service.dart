import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

Logger _log = Logger('main.dart');

class AudioService {
  static final AudioService _instance = AudioService._internal();
  final AudioPlayer _player = AudioPlayer();
  bool _isInitialized = false;

  factory AudioService() {
    return _instance;
  }

  AudioService._internal();

  Future<void> initialize() async {
    if (!_isInitialized) {
      await _player.setAsset('assets/audio/background_music.mp3');
      await _player.setLoopMode(LoopMode.all);
      _log.info("Music initialized");
      _isInitialized = true;
    }
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}