import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NoteForm extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String note = '';
  List notes = [];

  saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'data': notes});
    prefs.setString('data', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создание заметки"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Заголовок",
                      labelText: "Заголовок",
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Заметка';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      title = value;
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: new InputDecoration(
                      hintText: "Текст заметки",
                      labelText: "Текст заметки",
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Текст заметки пуст';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      note = value;
                    }),
              ),
              RaisedButton(
                child: Text(
                  "Сохранить заметку",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    /** получаем все заметки перед сохранением в sharedPreferences */
                    notes = (sharedPrefs.data != '')
                        ? jsonDecode(sharedPrefs.data)['data']
                        : [];
                    notes.add({'title': title, 'note': note});

                    saveNote();
                    Navigator.pushNamed(context, '/');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
