import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:music_swap/pages/song_page.dart';
import 'package:provider/provider.dart';
import '../components/custom_play_button.dart';
import '../models/playlist_provider.dart';
import '../models/song.dart';

class MusicSwipe extends StatefulWidget {
  const MusicSwipe({super.key});

  @override
  State<MusicSwipe> createState() => _MusicSwipeState();
}

class _MusicSwipeState extends State<MusicSwipe> {
  late final dynamic playListProvider;

  @override
  void initState() {
    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
    super.initState();
  }

  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final List<Song> playlist = value.playlist;
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight / 35),
          Swiper(
            itemCount: playlist.length,
            layout: SwiperLayout.STACK,
            axisDirection: AxisDirection.right,
            itemHeight: screenHeight / 1.9,
            itemWidth: screenWidth / 1.2,
            loop: false,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(playlist[index].albumArtImagePath),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      playlist[index].songName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      playlist[index].artisName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      playlist[index].relaseDate,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomPlayButton(
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  onTap: () {
                                    goToSong(index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
