import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morti/core/error/failure.dart';
import 'package:rick_and_morti/feature/domain/usecases/get_episode.dart';
import 'package:rick_and_morti/feature/presentation/bloc/episode_cubit/person_episode_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';

class EpisodeCubit extends Cubit<EpisodeState> {
  late final GetEpisode getEpisode;

  EpisodeCubit({required this.getEpisode}) : super(EpisodeStateEmpty());

  void loadEpisode(String url) async {
    if (state is EpisodeStateLoading) {
      return;
    }
    final failureOrPerson = await getEpisode(UrlEpisodeParams(url: url));
    failureOrPerson.fold((error) {
      return EpisodeStateError(message: _mapFailureToMessage(error));
    }, (episode) {
      emit(EpisodeStateLoaded(episode));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    print(failure);
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
