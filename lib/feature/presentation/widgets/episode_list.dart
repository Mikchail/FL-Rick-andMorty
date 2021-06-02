import 'package:flutter/material.dart';
import 'package:rick_and_morti/common/app_colors.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';

import '../pages/episode_screen.dart';

class EpisodeList extends StatelessWidget {
  final PersonEntity person;
  const EpisodeList({required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 3,),
      Text("Episodes: "),
      const SizedBox(height: 3,),
      Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
                  width: 16,
                ),
            itemCount: person.episode.length,
            itemBuilder: (context, index) {
              // BlocProvider.of<EpisodeCubit>(context).loadEpisode(person.episode[index]);
              // context.read<EpisodeCubit>().loadEpisode(person.episode[index]);
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EpisodePage(url: person.episode[index]);
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.cellBackground,
                  ),
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${index + 1}"),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    ]);
  }
// Widget _episode() {
//   return Container(
//     height: 140,
//     padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
//     child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         separatorBuilder: (context,index) => SizedBox(width: 16,),
//         itemCount: person.episode.length,
//         itemBuilder: (context,index) {
//           var episode = BlocProvider.of<EpisodeCubit>(context).loadEpisode(person.episode[index]);
//           print("$episode");
//           return Container(
//             width: MediaQuery.of(context).size.width / 2.7,
//             height: 160,
//             color: Colors.black87,
//             child: Text("${person.episode[index]}"),
//           ),
//         }
//     ),
//   )
// }
}
