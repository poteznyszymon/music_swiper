import 'package:flutter/material.dart';
import 'package:music_swap/components/change_theme_button.dart';
import 'package:music_swap/components/custom_back_button.dart';
import 'package:music_swap/components/custom_play_button.dart';
import 'package:music_swap/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formatedTime = '${duration.inMinutes}:$twoDigitSeconds';
    return formatedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;
        final song = playlist[value.currentSongIndex];
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            toolbarHeight: MediaQuery.of(context).size.height / 15 + 20,
            leadingWidth: (MediaQuery.of(context).size.height / 15) + 25,
            centerTitle: true,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Now playing',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 25, top: 20),
              child: CustomBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 25, top: 20),
                child: ChangeThemeButton(),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(song.albumArtImagePath),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.songName,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          song.artisName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<PlaylistProvider>(context, listen: false)
                            .setSongLikeOrNot(song.id.toString());
                      },
                      icon: Icon(
                        song.liked ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 4),
                  trackHeight: 2,
                  thumbColor: Theme.of(context).colorScheme.inversePrimary,
                  inactiveTrackColor: Colors.grey.shade600,
                  activeTrackColor:
                      Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Slider(
                  min: 0,
                  max: value.totalDuration.inSeconds.toDouble(),
                  value: value.currentDuration.inSeconds.toDouble(),
                  onChanged: (double double) {
                    value.seek(
                      Duration(
                        seconds: double.toInt(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(value.currentDuration),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      formatTime(value.totalDuration),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomPlayButton(
                    icon: Icon(
                      value.isPlaying ? Icons.play_arrow : Icons.pause,
                      size: 35,
                    ),
                    onTap: () {
                      value.playOrResume();
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
