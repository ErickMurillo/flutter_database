import 'package:flutter_database/src/models/cursos_model.dart';
import 'db_provider.dart';
import 'package:dio/dio.dart';

class CursosApiProvider {
  Future<List<Cursos>> getAllCursos() async {
    var url = "http://ampb.caps-nicaragua.org/aprende/api/cursos/";
    Response response = await Dio().get(url);

    return (response.data as List).map((cursos) {
      print('Inserting $cursos');
      DBProvider.db.createCursos(Cursos.fromJson(cursos));
    }).toList();
  }
}
