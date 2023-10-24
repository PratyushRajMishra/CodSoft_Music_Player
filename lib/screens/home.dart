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
    filteredSongs.assignAll(songsList); // Initialize filteredSongs with all songs
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
      backgroundColor: Colors.black,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.person_2_outlined, color: Colors.white),
          );
        },
      ),
      title: Text(
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
          icon: Icon(Icons.search, color: Colors.white),
        ),
      ],
    );
  }

  AppBar buildSearchAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: TextField(
        controller: searchController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
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
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: NavbarPage(),
      appBar: isSearching.value ? buildSearchAppBar() : buildDefaultAppBar(),
      body: Obx(() {
        return songs.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: isSearching.value
              ? filteredSongs.length
              : songs.length,
          itemBuilder: (context, index) {
            final song = isSearching.value
                ? filteredSongs[index]
                : songs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              child: Obx(
                    () => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.blueGrey,
                  title: Text(
                    song.title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    song.artist ?? "",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Icon(
                      Icons.music_note,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  trailing: controller.playIndex == index &&
                      controller.isPlaying.value
                      ? Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 26,
                  )
                      : null,
                  onTap: () {
                    Get.to(
                          () => PlayerScreen(data: songs),
                      transition: Transition.downToUp,
                    );
                    controller.playSong(song.uri.toString(), index);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
