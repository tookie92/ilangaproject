import 'package:flutter/material.dart';
import 'package:ilanga/blocs/bloc_provider.dart';
import 'package:ilanga/blocs/bloc_task.dart';
import 'package:ilanga/ui/widgets/text_field.dart';

class Crudity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final bloc = BlocProvider.of<BlocTask>(context);
    return Scaffold(
      body: StreamBuilder<TaskState>(
        stream: bloc.stream,
        builder: (context, s) {
          if (s.data == null) {
            return Center(child: Text('alles klar! nein'));
          } else if (!s.hasData) {
            return Center(child: Text('alles klar! nein'));
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Crud'),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      //autovalidateMode: AutovalidateMode.always,
                      key: _formkey,
                      child: Column(
                        children: [
                          MyTextField(
                            //textEditingController: _titleController,
                            initialValue: '',
                            label: 'label',
                            validator: (value) =>
                                value.isEmpty ? 'Please' : null,
                            onSaved: (newValue) => s.data.task.title = newValue,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();

                            s.data.createData();
                          }
                        },
                        child: Text('create')),
                    Center(child: Text(s.data.task.title.length.toString())),
                  ],
                ));
          }
        },
      ),
    );
  }
}
