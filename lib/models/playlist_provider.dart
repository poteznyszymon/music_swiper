import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_swap/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      id: '0',
      songName: 'Loading',
      artisName: 'Centrall Cee',
      albumArtImagePath: 'assets/images/album_1.jpg',
      audioPath: 'audio/loading.mp3',
      relaseDate: '2021',
    ),
    Song(
      id: '1',
      songName: 'Save Your Tears',
      artisName: 'The weekend',
      albumArtImagePath: 'assets/images/album_2.jpg',
      audioPath: 'audio/saveyourtears.mp3',
      relaseDate: '2020',
    ),
    Song(
      id: '2',
      songName: "God's plan",
      artisName: 'Drake',
      albumArtImagePath: 'assets/images/album_3.jpg',
      audioPath: "audio/god'splan.mp3",
      relaseDate: '2018',
    ),
    Song(
      id: '3',
      songName: "P.S.W.I.S. (DJ Eprom remix)",
      artisName: 'Belmondawg',
      albumArtImagePath: 'assets/images/album_4.jpg',
      audioPath: 'audio/pswis.mp3',
      relaseDate: '2021',
    ),
    Song(
      id: '4',
      songName: "Bolesław Krzywousty",
      artisName: 'Kaz Balagane',
      albumArtImagePath: 'assets/images/album_5.jpg',
      audioPath: 'audio/krzywousty.mp3',
      relaseDate: '2021',
    )
  ];

  final List<Song> _likedPlaylist = [];

  void setSongLikeOrNot(String songId) {
    final songIndex = _playlist.indexWhere((song) => song.id == songId);
    final likedSongIndex =
        _likedPlaylist.indexWhere((song) => song.id == songId);
    if (songIndex != -1) {
      if (_playlist[songIndex].liked) {
        _playlist[songIndex].liked = !_playlist[songIndex].liked;
        _likedPlaylist.removeAt(likedSongIndex);
      } else {
        _playlist[songIndex].liked = !_playlist[songIndex].liked;
        _likedPlaylist.insert(
          0,
          Song(
            id: _playlist[songIndex].id,
            songName: _playlist[songIndex].songName,
            artisName: _playlist[songIndex].artisName,
            albumArtImagePath: _playlist[songIndex].albumArtImagePath,
            audioPath: _playlist[songIndex].audioPath,
            relaseDate: _playlist[songIndex].relaseDate,
            liked: true,
          ),
        );
      }
      notifyListeners();
    }
  }

  void deleteLikedSong(int index) {
    _likedPlaylist.removeAt(index);
    notifyListeners();
  }

  int? _pageIndex;
  int? _currentSongIndex;
  int? _currentLikedSongIndex;
  bool isLikedPageActive = false;
  bool _isLikedPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    isLikedPageActive = false;
    _isLikedPlaying = false;
    notifyListeners();
  }

  void playLiked() async {
    final String path = _likedPlaylist[_currentLikedSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    isLikedPageActive = true;
    _isLikedPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    _isLikedPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void playOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playNextLikedSong() {
    if (_currentLikedSongIndex != null) {
      if (_currentLikedSongIndex! < _likedPlaylist.length - 1) {
        currentLikedSongIndex = _currentLikedSongIndex! + 1;
      } else {
        currentLikedSongIndex = 0;
      }
    }
  }

  void playPreviusSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void playPreviusLikedSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentLikedSongIndex! > 0) {
        currentLikedSongIndex = _currentLikedSongIndex! - 1;
      } else {
        currentLikedSongIndex = _likedPlaylist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (isLikedPageActive) {
        playNextLikedSong();
      } else {
        playNextSong();
      }
    });
  }

  // GETTERS
  List<Song> get playlist => _playlist;
  List<Song> get likedPlaylist => _likedPlaylist;
  int get currentSongIndex => _currentSongIndex!;
  int get currentLikedSongIndex => _currentLikedSongIndex!;
  int get pageIndex => _pageIndex!;
  bool get isPlaying => _isPlaying;
  bool get isLikedPlaying => _isLikedPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // SETTERS

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }

  set currentLikedSongIndex(int? newIndex) {
    _currentLikedSongIndex = newIndex;

    if (newIndex != null) {
      playLiked();
    }
    notifyListeners();
  }

  set pageIndex(int? newPageIndex) {
    _pageIndex = newPageIndex;
    notifyListeners();
  }
}
