import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';

class EpisodeModel extends EpisodeEntity {
  EpisodeModel({name, id, airDate, episode, characters})
      : super(
            name: name,
            airDate: airDate,
            characters: characters,
            id: id,
            episode: episode);

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
        name: json["name"],
        airDate: json["air_date"],
        id: json["id"],
        characters: json["characters"],
        episode: json["episode"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "air_date": airDate,
      "id": id,
      "characters": characters,
      "episode": episode,
    };
  }
}
