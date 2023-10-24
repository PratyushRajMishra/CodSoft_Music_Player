import 'package:flutter/material.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/music_logo_dark.png",
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "GrooveX",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Local User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("localuser@groovex.com",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )),
            SizedBox(
              height: 25,
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Favourite',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.featured_play_list_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Playlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.feedback_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Feedback',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Share',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Sign out',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
