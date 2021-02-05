import 'dart:convert';

List<Cursos> cursosFromJson(String str) =>
    List<Cursos>.from(json.decode(str).map((x) => Cursos.fromJson(x)));

String cursosToJson(List<Cursos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cursos {
  int id;
  String titulo;
  String imagen;
  String descripcion;
  String fecha;
  int activo;

  Cursos(
      {this.id,
      this.titulo,
      this.imagen,
      this.descripcion,
      this.fecha,
      this.activo});

  factory Cursos.fromJson(Map<String, dynamic> json) => Cursos(
      id: json["id"],
      titulo: json["titulo"],
      imagen: json["imagen"],
      descripcion: json["descripcion"],
      fecha: json["fecha"],
      activo: json["activo"] == true ? 0 : 1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "imagen": imagen,
        "descripcion": descripcion,
        "fecha": fecha,
        "activo": activo
      };
}
