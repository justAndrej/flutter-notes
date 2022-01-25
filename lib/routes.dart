import 'package:flutter/material.dart';
import 'package:notes/screen/NoteList.dart';
import 'package:notes/screen/NoteForm.dart';
import 'package:notes/screen/NoteShow.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => NoteList());
      case '/form':
        return MaterialPageRoute(builder: (_) => NoteForm());
      case '/show':
        return MaterialPageRoute(builder: (_) => NoteShow());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Ошибка")),
        body: Center(child: Text('Что-то пошло не так')),
      );
    });
  }
}
