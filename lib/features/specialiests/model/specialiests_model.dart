import 'dart:convert';

import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/model/names_model.dart';

//specialiests
class SpecialiestsModel {
  final int id;
  final Names name;
  final Names description;
  SpecialiestsModel(
      {required this.id, required this.name, required this.description});

  SpecialiestsModel copyWith({
    int? id,
    Names? name,
    Names? description,
  }) {
    return SpecialiestsModel(
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toJson(),
      'description': description.toJson(),
    };
  }

  factory SpecialiestsModel.fromMap(Map<String, dynamic> map) {
    logger("map $map");
    return SpecialiestsModel(
        id: map['id'] as int,
        name: Names.fromJson(map['name']),
        description: Names.fromJson(map['description']));
  }

  String toJson() => json.encode(toMap());

  factory SpecialiestsModel.fromJson(String source) =>
      SpecialiestsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Category(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant SpecialiestsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
