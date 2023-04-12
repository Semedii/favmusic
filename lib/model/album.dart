class Album {
  String? imageUrl;
  String albumName;
  String artistName;
  String releaseDate;
  int trackCount;
  String albumLink;

  Album(
      {this.imageUrl,
      required this.albumName,
      required this.artistName,
      required this.releaseDate,
      required this.trackCount,
      required this.albumLink});
}
