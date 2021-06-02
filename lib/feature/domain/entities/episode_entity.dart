
class EpisodeEntity {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<dynamic> characters;

  EpisodeEntity(
      {required this.id,
        required this.name,
        required this.airDate,
        required this.episode,
        required this.characters});
}