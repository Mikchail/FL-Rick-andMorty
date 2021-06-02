import 'package:dartz/dartz.dart';
import 'package:rick_and_morti/core/error/exeptions.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/core/platform/network_info.dart';
import 'package:rick_and_morti/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morti/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morti/feature/data/models/person_model.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morti/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => remoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() => remoteDataSource.serachPerson(query));
  }

  Future<Either<Failure, List<PersonEntity>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    bool isConnect = await networkInfo.isConnected;
    print("_getPersons");
    if (isConnect) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locatePerson = await localDataSource.getLastPersonsFromCache();
        return Right(locatePerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }


}
