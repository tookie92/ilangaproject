import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_task.dart';
import 'package:ilanga/ui/settings/palette.dart';

class Crudity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocTask>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Palette.monNoir,
      height: size.height,
      width: size.width,
      child: ListView(
        children: [
          StreamBuilder<TaskState>(
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
                return Stack(
                  children: [Positioned(child: Text('Hey'))],
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
