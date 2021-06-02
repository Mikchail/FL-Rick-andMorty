import 'dart:convert';
import 'package:rick_and_morti/core/error/exeptions.dart';
import 'package:rick_and_morti/feature/data/models/episode_model.dart';
import 'package:rick_and_morti/feature/data/models/person_model.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);

  Future<List<PersonModel>> serachPerson(String query);

  Future<EpisodeEntity> getEpisode(String url);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonsFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override
  Future<List<PersonModel>> serachPerson(String query) => _getPersonsFromUrl(
      "https://rickandmortyapi.com/api/character/?name=$query");

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

  Future<List<PersonModel>> _getPersonsFromUrl(url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      var data = (persons['results'] as List)
          .map((p) => PersonModel.fromJson(p))
          .toList();
      return data;
    } else {
      throw ServerException();
    }
  }
}
