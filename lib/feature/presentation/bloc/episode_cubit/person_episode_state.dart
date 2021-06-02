import 'package:equatable/equatable.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';

abstract class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object?> get props => [];
}

class EpisodeStateEmpty extends EpisodeState {
  @override
  List<Object?> get props => [];
}

class EpisodeStateError extends EpisodeState {
  final String message;

  EpisodeStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class EpisodeStateLoading extends EpisodeState {
  final EpisodeEntity episode;

  EpisodeStateLoading(this.episode);

  @override
  List<Object?> get props => [episode];
}

class EpisodeStateLoaded extends EpisodeState {
  final EpisodeEntity episode;

  EpisodeStateLoaded(this.episode);

  @override
  List<Object?> get props => [episode];
}
