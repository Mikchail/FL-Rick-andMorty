import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morti/core/platform/network_info.dart';
import 'package:rick_and_morti/feature/data/datasources/episode_remote_data_source.dart';
import 'package:rick_and_morti/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morti/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morti/feature/data/repositories/episode_reposytory_impl.dart';
import 'package:rick_and_morti/feature/domain/repositories/episode_repository.dart';
import 'package:rick_and_morti/feature/domain/repositories/person_repository.dart';
import 'package:rick_and_morti/feature/domain/usecases/get_episode.dart';
import 'package:rick_and_morti/feature/presentation/bloc/episode_cubit/person_episode_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/data/repositories/person_repository_impl.dart';
import 'feature/domain/usecases/get_all_persons.dart';
import 'feature/domain/usecases/search_person.dart';
import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/presentation/bloc/search_bloc/search_bloc.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
        () => PersonListCubit(getAllPersons: sl()),
  );
  sl.registerFactory(
        () => EpisodeCubit(getEpisode: sl()),
  );
  sl.registerFactory(
        () => PersonSearchBloc(searchPerson: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));
  sl.registerLazySingleton(() => GetEpisode(sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(
        () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<EpisodeRepository>(
        () => EpisodeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
        () => PersonRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<EpisodeRemoteDataSourceImpl>(
        () => EpisodeRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
        () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

  // External
  final  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}