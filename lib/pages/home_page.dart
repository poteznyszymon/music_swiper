import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_swap/pages/liked_page.dart';
import 'package:music_swap/pages/music_swipe.dart';
import '../components/change_theme_button.dart';
import '../components/profile_image_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [MusicSwipe(), LikedPage()];
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: GNav(
            onTabChange: (value) {
              setState(() {
                _selectedPage = value;
              });
            },
            gap: 8,
            backgroundColor: Theme.of(context).colorScheme.background,
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            color: Colors.white,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(15),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Liked songs',
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          toolbarHeight: MediaQuery.of(context).size.height / 15 + 20,
          leadingWidth: (MediaQuery.of(context).size.height / 15) + 25,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'hi,',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16),
                ),
                Text(
                  'Jake',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: ProfileImageTile(),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 25, top: 20),
              child: ChangeThemeButton(),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _pages[_selectedPage]);
  }
}
