import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_task.dart';

import '../../models/tasks.dart';
import '../settings/palette.dart';

import '../widgets/all_widgets.dart';
import '../widgets/nur_text.dart';

class Crudity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocTask>(context);
    final size = MediaQuery.of(context).size;
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Palette.monNoir,
        body: StreamBuilder<TaskState>(
          stream: bloc.stream,
          builder: (context, s) {
            final truc = s.data;

            if (truc == null && s == null) {
              return Center(child: Text('Da ist nichts zu zeigen'));
            } else if (!s.hasData) {
              return Center(
                child: Text('Leider nichts'),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  //color: Colors.amber,
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.08),
                        MyText(
                          label: 'Hey\n${truc.currentUser.displayName}',
                          fontSize: 30.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Form(
                              key: _formkey,
                              child: Container(
                                width: size.width * 0.6,
                                child: MyTextField(
                                  label: 'label',
                                  validator: (value) => value.isEmpty
                                      ? 'Please enter a task'
                                      : null,
                                  onSaved: (newValue) =>
                                      truc.task.title = newValue,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            MyTextButton(
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  _formkey.currentState.save();
                                  await truc.createData();
                                }
                                _formkey.currentState.reset();
                              },
                              label: 'task',
                              colorText: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.4,
                                width: size.width,
                                child: FirebaseAnimatedList(
                                  query: truc.databaseReference,
                                  key: ValueKey<bool>(true),
                                  //reverse: true,
                                  sort: true
                                      ? (DataSnapshot a, DataSnapshot b) =>
                                          b.key.compareTo(a.key)
                                      // ignore: dead_code
                                      : null,
                                  itemBuilder: (BuildContext context,
                                      DataSnapshot snapshot,
                                      Animation<double> animation,
                                      int index) {
                                    return SizeTransition(
                                      sizeFactor: animation,
                                      child: showTask(snapshot),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }

  showTask(DataSnapshot res) {
    Task task = Task.fromSnapshot(res);

    var item = Card(
      elevation: 2.0,
      color: Palette.interieur,
      child: Container(
        width: 350.0,
        height: 100.0,
        child: Stack(
          children: [
            Container(
              width: 05.0,
              decoration: BoxDecoration(color: Colors.purple[900]),
            ),
            Positioned(
              top: 10.0,
              left: 15.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    label: task.title,
                    fontSize: 20.0,
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 10.0,
                right: 08.0,
                child: MyText(
                  label: task.user,
                ))
          ],
        ),
      ),
    );
    return item;
  }
}
