import 'dart:convert';
import 'dart:developer';

import 'package:rick_and_morti/core/error/exeptions.dart';
import 'package:rick_and_morti/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personToCache(List<PersonModel> persons);
}

const CACHED_PERSON_LIST = "CACHED_PERSON_LIST";

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;
  PersonLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonList = sharedPreferences.getStringList(CACHED_PERSON_LIST);
    if(jsonPersonList != null && jsonPersonList.isNotEmpty){
      return Future.value(jsonPersonList.map((person)=> PersonModel.fromJson(json.decode(person))).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSON_LIST, jsonPersonsList);
    print('Persons to write Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
  
}

