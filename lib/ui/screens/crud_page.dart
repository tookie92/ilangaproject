import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_task.dart';
import 'package:ilanga/ui/settings/palette.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: MyText(
                          label: 'Hey\n${truc.currentUser.displayName}',
                          fontSize: 30.0,
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
