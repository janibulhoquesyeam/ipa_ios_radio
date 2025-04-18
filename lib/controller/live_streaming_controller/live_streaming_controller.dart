import 'dart:async';

import 'package:adradio/backend/utils/custom_snackbar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../backend/model/dashboard/live_show_model.dart';
import '../../backend/services/dashboard_services/dashboard_service.dart';
import '../../utils/basic_screen_imports.dart';

class LiveStreamingController extends GetxController with DashboardService {
  var setVolumeValue = 1.0.obs;
  final currentBitrate = "00kbps".obs;
  RxString radioUrl = ''.obs;

  RxString radioImage = ''.obs;
  RxString radioId = ''.obs;
  RxString radioTitle = ''.obs;
  RxString radioHost = ''.obs;
  RxString radioAlbum = ''.obs;

  late final Timer _usageTimer;
  final RxString dataUsage = " 0.00 MB".obs;
  final int assumedBitrateKbps = 64; // Adjust this value as needed








  void setVolume(double value) {
    setVolumeValue.value = value;
    audioPlayer.setVolume(value);
  }

  RxBool isPlaying = false.obs;
  RxBool isPlayLoading = false.obs;
  late AudioPlayer audioPlayer;

  void playRadio() async {
    isPlayLoading.value = true;
    update();
    if (!isPlaying.value) {
      try {

        await audioPlayer.play();
        isPlaying.value = true;
        startUsageTimer();
        update();
      } catch (e) {
        // CustomSnackBar.error("");
      }
    } else {
      isPlaying.value = false;
      await audioPlayer.stop();
      stopUsageTimer();
      update();
    }
    isPlayLoading.value = false;
    update();
  }



  void startUsageTimer() {
    _usageTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = audioPlayer.position; // Use position instead of duration
      final seconds = duration.inSeconds;
      final mb = (assumedBitrateKbps * seconds) / 8 / 1024;
      dataUsage.value = "${mb.toStringAsFixed(2)} MB";
    });
  }

  void stopUsageTimer() {
    _usageTimer.cancel();
  }



  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    if (_usageTimer.isActive) {
      _usageTimer.cancel();
    }
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();

    liveShowProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late LiveShowModel _liveShowModel;
  LiveShowModel get liveShowModel => _liveShowModel;




  ///* Get LiveShow in process
  Future<LiveShowModel> liveShowProcess() async {
    _isLoading.value = true;
    update();
    await liveShowProcessApi().then((value) async {
      _liveShowModel = value!;

      radioUrl.value = "https://26423.live.streamtheworld.com/WLTRFM.mp3";
      radioUrl.value = _liveShowModel.data.schedule.first.radioLink;

      radioImage.value = _liveShowModel.data.schedule.first.image;
      radioId.value = _liveShowModel.data.schedule.first.id.toString();
      radioTitle.value = _liveShowModel.data.schedule.first.name;
      radioHost.value = _liveShowModel.data.schedule.first.host;
      radioAlbum.value = _liveShowModel.data.schedule.first.description;


      // Create the ConcatenatingAudioSource with the MediaItem as the tag
      final playlist = ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(radioUrl.value),
            tag: MediaItem(
              id: radioId.value,
              title: radioTitle.value,
              artist: radioHost.value,
              album: radioAlbum.value,
              artUri: Uri.parse("https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png"),
            ), // Use the MediaItem here
          ),
        ],
      );

      _isLoading.value = false;
      update();

      // Future<void> _init() async{
      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.setAudioSource(playlist);

      // }
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _liveShowModel;
  }
}
