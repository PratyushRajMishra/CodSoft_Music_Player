import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groovex/controllers/player_controller.dart';
import 'package:groovex/screens/login.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:math';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> data;
  final PlayerController controller;

  const PlayerScreen({Key? key, required this.data, required this.controller}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  //final controller = Get.put<PlayerController>(PlayerController());

  @override
  void initState() {
    super.initState();

    // Add a listener for player state changes in the passed controller
    widget.controller.audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  void playNextSong() {
    int nextIndex;

    if (widget.controller.isShuffleEnabled.value) {
      // Shuffle is enabled, select a random song
      nextIndex = Random().nextInt(widget.data.length);
    } else {
      // Shuffle is disabled, play songs sequentially
      nextIndex = widget.controller.playIndex.value + 1;
      if (nextIndex >= widget.data.length) {
        nextIndex = 0;
      }
    }

    widget.controller.playSong(widget.data[nextIndex].uri.toString(), nextIndex);
  }

  void playPreviousSong() {
    int previousIndex;

    if (widget.controller.isShuffleEnabled.value) {
      previousIndex = Random().nextInt(widget.data.length);
    } else {
      previousIndex = widget.controller.playIndex.value - 1;
      if (previousIndex < 0) {
        previousIndex = widget.data.length - 1;
      }
    }

    widget.controller.playSong(
        widget.data[previousIndex].uri.toString(), previousIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('NOW PLAYING', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: 1.2),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.expand_more, size: 40,)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz, size: 30,)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: widget.data[widget.controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Image.asset(
                      "assets/music_logo_dark.png",
                      width: 350,
                      height: 350,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.data[widget.controller.playIndex.value].title ??
                            'Music name',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.data[widget.controller.playIndex.value].artist ??
                            'Artist name',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                widget.controller.toggleShuffle();
                              },
                              icon: Obx(() => Icon(
                                    widget.controller.isShuffleEnabled.value
                                        ? Icons.shuffle_on_outlined
                                        : Icons.shuffle,
                                    size: 35,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                      () => LoginPage(),
                                  transition: Transition.upToDown, // Use a Cupertino-style transition
                                  duration: Duration(milliseconds: 500), // Adjust the duration as needed
                                );
                              },
                              child: Icon(
                                Icons.favorite_border_outlined,
                                size: 35,
                              ),
                            ),
                          ),

                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                      () => LoginPage(),
                                  transition: Transition.upToDown, // Use a Cupertino-style transition
                                  duration: Duration(milliseconds: 500), // Adjust the duration as needed
                                );
                              },
                              child: Icon(
                                Icons.playlist_add,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            Text(
                              widget.controller.position.value,
                              style: TextStyle(color: Colors.black),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: Colors.deepPurpleAccent,
                                inactiveColor: Colors.black,
                                activeColor: Colors.deepPurpleAccent,
                                min: 0.0,
                                max: widget.controller.max.value,
                                value: widget.controller.value.value,
                                onChanged: (newValue) {
                                  widget.controller.changeDurationToSeconds(
                                    newValue.toInt(),
                                  );
                                },
                              ),
                            ),
                            Text(
                              widget.controller.duration.value,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              playPreviousSong();
                            },
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                            ),
                          ),
                          Obx(() {
                            return CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.black,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (widget.controller.isPlaying.value) {
                                      widget.controller.audioPlayer.pause();
                                      widget.controller.isPlaying(false);
                                    } else {
                                      widget.controller.audioPlayer.play();
                                      widget.controller.isPlaying(true);
                                    }
                                  },
                                  icon: widget.controller.isPlaying.value
                                      ? Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  )
                                      : Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            onPressed: playNextSong,
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
