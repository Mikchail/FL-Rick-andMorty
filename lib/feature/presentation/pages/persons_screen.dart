import 'package:flutter/material.dart';
import 'package:rick_and_morti/feature/presentation/pages/search_person_screen.dart';
import 'package:rick_and_morti/feature/presentation/widgets/person_list_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Characters'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SearchPersonScreen();
                }));

                if (tappedName != null) {
                  print(tappedName);
                }
              },
            )
          ],
        ),
        body: PersonList());
  }
}
