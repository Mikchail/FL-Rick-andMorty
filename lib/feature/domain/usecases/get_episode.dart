import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/core/usecases/usecases.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/domain/repositories/episode_repository.dart';

class GetEpisode extends UseCase<EpisodeEntity, UrlEpisodeParams> {
  final EpisodeRepository episodeRepository;

  GetEpisode(this.episodeRepository);

  Future<Either<Failure, EpisodeEntity>> call(UrlEpisodeParams params) async {
    return await episodeRepository.getEpisode(params.url);
  }
}

class UrlEpisodeParams extends Equatable {
  final String url;

  UrlEpisodeParams({required this.url});

  @override
  List<Object> get props => [url];
}