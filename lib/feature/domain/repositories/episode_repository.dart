import 'package:dartz/dartz.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';

abstract class EpisodeRepository {
  Future<Either<Failure, EpisodeEntity>> getEpisode(String url);
}