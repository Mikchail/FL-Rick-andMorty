import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morti/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morti/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morti/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morti/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morti/feature/presentation/widgets/input_search_name.dart';
import 'package:rick_and_morti/feature/presentation/widgets/person_card.dart';

class SearchPersonScreen extends StatelessWidget {
  String searchName = "";

  SearchPersonScreen({Key? key}) : super(key: key);

  Function _getSearchName(context) {
    return (value) {
      print(value);
      BlocProvider.of<PersonSearchBloc>(context).add(SearchPersons(value));
      searchName = value;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Person"),
          centerTitle: true,
        ),
        body: BlocBuilder<PersonSearchBloc, PersonSearchState>(
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InputSearchName(callback: _getSearchName(context)),
                  getList(state, searchName)
                ],
              ),
            );
          },
        ));
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getList(state, searchName) {
    List<PersonEntity> persons = [];
    if (searchName == "") {
      return Text("Nothing");
    }
    if (state is PersonSearchLoading) {
      return _loadingIndicator();
    } else if (state is PersonSearchLoaded) {
      persons = state.persons;
    } else if (state is PersonSearchError) {
      return Text("${state.message}");
    }
    if (persons.length < 1) {
      return _loadingIndicator();
    }
    print(persons);
    return Expanded(
      child: ListView.separated(
          itemCount: persons.length,
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
              ),
          itemBuilder: (context, index) {
            return PersonCard(person: persons[index]);
          }),
    );
  }
}
