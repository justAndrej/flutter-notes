import 'package:notes/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NoteShow extends StatefulWidget {
  @override
  _NoteShowState createState() => _NoteShowState();
}

class _NoteShowState extends State<NoteShow> {
  final _formKey = GlobalKey<FormState>();

  /** Объявляем переменные для заголовка и текста заметки */
  String title = '';
  String note = '';

  /** Получаем текущую заметку после тапа в списке*/
  getCurrentQuote() async {
    if (sharedPrefs.data != 'null') {
      title = jsonDecode(sharedPrefs.currentData)['title'];
      note = jsonDecode(sharedPrefs.currentData)['note'];
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentQuote();
    return Scaffold(
      appBar: AppBar(
        title: Text("Показ заметки"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text("Заголовок: " + title,
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                child: Text(note),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
