import 'package:dartz/dartz.dart';
import 'package:rick_and_morti/core/error/exeptions.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/core/platform/network_info.dart';
import 'package:rick_and_morti/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morti/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/domain/repositories/episode_repository.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final PersonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EpisodeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, EpisodeEntity>> getEpisode(String url) async {
    bool isConnect = await networkInfo.isConnected;
    if (isConnect) {
      try {
        final episode = await remoteDataSource.getEpisode(url);
        return Right(episode);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
