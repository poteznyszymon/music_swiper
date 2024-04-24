import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_swap/pages/playlist_player_page.dart';
import 'package:provider/provider.dart';

import '../models/playlist_provider.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late final dynamic playListProvider;

  @override
  void initState() {
    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
    super.initState();
  }

  void goToSong(int songIndex) {
    playListProvider.currentLikedSongIndex = songIndex;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PlaylistPlayerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final likedPlaylist = value.likedPlaylist;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Text(
              'Liked songs',
              style: GoogleFonts.inter(
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Text(
              '${likedPlaylist.length} songs',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: ListView.builder(
                itemCount: likedPlaylist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => goToSong(index),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    leading: Image.asset(
                      likedPlaylist[index].albumArtImagePath,
                    ),
                    title: Text(likedPlaylist[index].songName),
                    subtitle: Text(likedPlaylist[index].artisName),
                    trailing: value.isLikedPlaying &&
                            index == value.currentLikedSongIndex
                        ? Lottie.asset(
                            'assets/animations/music.json',
                            height: 35,
                          )
                        : IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                alignment: Alignment.bottomCenter,
                                contentPadding: const EdgeInsets.all(0),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FilledButton(
                                      onPressed: () {
                                        value.deleteLikedSong(index);
                                        Navigator.pop(context);
                                      },
                                      style: FilledButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      child: Text(
                                        'Delete',
                                        style: GoogleFonts.inter(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            fontSize: 16),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.inter(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.more_vert),
                          ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
