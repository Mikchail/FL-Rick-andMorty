import 'package:flutter/material.dart';
import 'package:rick_and_morti/common/app_colors.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morti/feature/presentation/widgets/episode_list.dart';

class PersonPage extends StatelessWidget {
  final PersonEntity person;

  PersonPage({required this.person});

  @override
  Widget build(BuildContext context) {
    var type = person.type != "" ? person.type : "None";
    return Scaffold(
      appBar: AppBar(
        title: Text("${person.name}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.network(person.image),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      person.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: person.status == 'Alive'
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${person.status} - ${person.species}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Last known location:',
                      style: TextStyle(color: AppColors.greyColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      person.location.name,
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Origin:',
                      style: TextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      person.origin.name,
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Gender:',
                      style: TextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      person.gender,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Type:',
                      style: TextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      type,
                      style: TextStyle(color: Colors.white),
                    ),

                    EpisodeList(person: person),
                  ],
                ),

              ],
            ),

          ),

        ],
      ),
    );
  }
}
