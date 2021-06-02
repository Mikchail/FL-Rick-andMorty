import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morti/feature/domain/entities/episode_entity.dart';
import 'package:rick_and_morti/feature/presentation/bloc/episode_cubit/person_episode_cubit.dart';
import 'package:rick_and_morti/feature/presentation/bloc/episode_cubit/person_episode_state.dart';

class EpisodePage extends StatelessWidget {
  final String url;
  bool isLoad = false;

  EpisodePage({Key? key, required this.url}) : super(key: key);

  void getEpisode(BuildContext context) {
    if (!isLoad) {
      context.read<EpisodeCubit>().loadEpisode(url);
      isLoad = true;
    }
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeCubit, EpisodeState>(builder: (context, state) {
      EpisodeEntity episode;
      getEpisode(context);
      if (state is EpisodeStateLoading) {
        return _loadingIndicator();
      } else if (state is EpisodeStateLoaded) {
        episode = state.episode;
        return Scaffold(
          appBar: AppBar(
            title: Text("${episode.name}"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              children: [Text("${episode.name}"), Text("${episode.airDate}")],
            ),
          ),
        );
      } else if (state is EpisodeStateError) {
        return Text("Erorr");
      }
      return Text("Erorr");
    });
  }
}
