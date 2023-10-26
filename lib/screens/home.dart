import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groovex/controllers/player_controller.dart';
import 'package:groovex/screens/SlideBar.dart';
import 'package:groovex/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(PlayerController());
  TextEditingController searchController = TextEditingController();
  RxList<SongModel> songs = <SongModel>[].obs;
  RxBool isSearching = false.obs;
  RxList<SongModel> filteredSongs = <SongModel>[].obs;

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  Future<void> loadSongs() async {
    final songsList = await controller.audioQuery.querySongs(
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
    );
    songs.assignAll(songsList);
    filteredSongs
        .assignAll(songsList); // Initialize filteredSongs with all songs
  }

  void updateFilteredSongs() {
    final query = searchController.text.toLowerCase();
    filteredSongs.assignAll(
      songs
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              (song.artist ?? "").toLowerCase().contains(query))
          .toList(),
    );
  }

  void toggleSearch() {
    setState(() {
      isSearching.value = !isSearching.value;
    });
    if (!isSearching.value) {
      searchController.clear();
      updateFilteredSongs();
    }
  }

  AppBar buildDefaultAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueGrey.shade900,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child:
                    Icon(Icons.person_2_outlined, color: Colors.blueGrey.shade900)),
          );
        },
      ),
      title: const Text(
        "GrooveX",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: toggleSearch,
          icon: const Icon(Icons.search, color: Colors.white),
        ),
      ],
    );
  }

  AppBar buildSearchAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueGrey.shade900,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.person_2_outlined, color: Colors.blueGrey.shade900)),
          );
        },
      ),
      title: TextField(
        autofocus: true,
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Search Songs',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          updateFilteredSongs();
        },
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: toggleSearch,
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      drawer: const NavbarPage(),
      appBar: isSearching.value ? buildSearchAppBar() : buildDefaultAppBar(),
      body: Obx(() {
        return songs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    isSearching.value ? filteredSongs.length : songs.length,
                itemBuilder: (context, index) {
                  final song =
                      isSearching.value ? filteredSongs[index] : songs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 0.0),
                    child: Obx(
                      () => ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          tileColor: Colors.blueGrey.shade900,
                          title: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              song.title,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey.shade50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            song.artist ?? "",
                            style: TextStyle(
                                fontSize: 10, color: Colors.blueGrey.shade50),
                          ),
                          leading: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.music_note,
                                size: 32,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                          ),
                          trailing: controller.playIndex == index &&
                                  controller.isPlaying.value
                              ? const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : null,
                          onTap: () {
                            Get.to(
                              () => PlayerScreen(
                                  data:
                                      isSearching.value ? filteredSongs : songs,
                                  controller: controller),
                              transition: Transition.downToUp,
                            );
                            controller.playSong(song.uri.toString(), index);
                          }),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: Obx(() {
        // Show the FAB only when a song is currently playing
        if (controller.isPlaying.value) {
          return FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.white,
            onPressed: () {
              // Open the player screen for the currently playing song
              Get.to(
                () => PlayerScreen(
                  data: isSearching.value ? filteredSongs : songs,
                  controller: controller,
                ),
                transition: Transition.downToUp,
              );
            },
            child: const Icon(
              Icons.play_arrow,
              color: Colors.black,
              size: 40,
            ),
          );
        } else {
          // Don't show the FAB if no song is playing
          return Container();
        }
      }),
    );
  }
}
