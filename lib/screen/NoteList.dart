import 'package:notes/screen/NoteShow.dart';
import 'package:notes/screen/NoteForm.dart';
import 'package:notes/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Класс для хранения данных в памяти
class Data {
  List _data;

  //функция для загрузки данных из SharedPreferences
  Data() {
    if (sharedPrefs.data != '') {
      _data = jsonDecode(sharedPrefs.data)['data'];
    } else {
      _data = [];
    }
  }

  /** Функция для получения заголовка */
  String getTitle(int index) {
    return _data[index]["title"];
  }

  /** Функция для получения текста заметки*/
  String getNote(int index) {
    return _data[index]["note"];
  }

  /** Функция для вычисления числа заметок */
  int getCount() {
    return _data.length;
  }

  /** Функция для получения заметки по индексу и возврата её как строку */
  String getByIndex(index) {
    return jsonEncode(_data[index]);
  }

  /** Очищаем хранилище и возвращаем его пустым*/
  removeAt(index) {
    _data.removeAt(index);
    return _data;
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  Data _data = new Data();

  /** Обновляем данные в хранилище (SharedPreferences) после удаления */
  void updateData(newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'data': newData});
    prefs.setString('data', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Заметки'),
        ),
        body: Padding(
          child: ListView.builder(
            itemCount: _data.getCount(),
            itemBuilder: (context, index) {
              /** This for delete quote by slide right or left */
              return Dismissible(
                  key: Key(_data.getByIndex(index)),
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.only(right: 40),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    final removeData = _data.removeAt(index);
                    setState(() => {removeData});
                    updateData(removeData);
                  },
                  child: _items(context, index));
            },
          ),
          padding: EdgeInsets.all(10),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/form');
          },
          tooltip: 'Создать заметку',
          child: Icon(Icons.add),
        ));
  }

  /** Виджет с карточкой заметки */
  Widget _items(BuildContext context, int index) {
    return InkWell(
      child: GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final data = jsonEncode({
            'title': _data.getTitle(index),
            'note': _data.getNote(index),
          });
          prefs.setString('currentData', data);
          Navigator.pushNamed(context, '/show');
        },
        child: Card(
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: ClipRRect(
              child: Container(
                height: 70,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_data.getNote(index)),
                          Text("Текст: " + _data.getTitle(index),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)))
                        ],
                      ),
                    ),
                    // Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
