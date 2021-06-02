import 'dart:convert';
import 'package:rick_and_morti/core/error/exeptions.dart';
import 'package:rick_and_morti/feature/data/models/episode_model.dart';
import 'package:rick_and_morti/feature/data/models/person_model.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:http/http.dart' as http;

abstract class EpisodeRemoteDataSource {
  Future<EpisodeEntity> getEpisode(String url);
}

class EpisodeRemoteDataSourceImpl implements EpisodeRemoteDataSource {
  final http.Client client;

  EpisodeRemoteDataSourceImpl({required this.client});

  @override
  Future<EpisodeEntity> getEpisode(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      try{
        final episode = json.decode(response.body);
        var data = EpisodeModel.fromJson(episode);
        return data;
      } catch (e){
        print(e);
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

}
