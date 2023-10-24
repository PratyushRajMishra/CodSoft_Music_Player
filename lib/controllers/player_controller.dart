import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var duration = ''.obs;
  var position = ''.obs;

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  var isShuffleEnabled = false.obs;
  List<SongModel> songs = <SongModel>[]; // Your list of songs

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }


  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void playSong(String uri, int index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri)),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      // Load your songs here
      songs = await audioQuery.querySongs();
    } else {
      checkPermission();
    }
  }

  void toggleShuffle() {
    isShuffleEnabled.value = !isShuffleEnabled.value;
  }

}
