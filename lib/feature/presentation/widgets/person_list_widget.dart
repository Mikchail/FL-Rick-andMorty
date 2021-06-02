import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morti/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morti/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morti/feature/presentation/widgets/person_card.dart';

class PersonList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<PersonListCubit>(context).loadPerson();
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isLoading = false;
        if (state is PersonStateLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonStateLoading) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonStateLoaded) {
          persons = state.personsList;
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: persons.length + (isLoading ? 1 : 0),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[400],
          ),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
              return _loadingIndicator();
            }
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
