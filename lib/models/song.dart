class Song {
  final String id;
  final String songName;
  final String artisName;
  final String albumArtImagePath;
  final String audioPath;
  final String relaseDate;
  bool liked;

  Song({
    required this.id,
    required this.songName,
    required this.artisName,
    required this.albumArtImagePath,
    required this.audioPath,
    required this.relaseDate,
    this.liked = false,
  });
}
