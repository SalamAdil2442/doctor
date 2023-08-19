import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tandrustito/core/shared/imports.dart';

class LocalFavs {
  final storage = const FlutterSecureStorage();
  static final LocalFavs _singleton = LocalFavs._();
  static LocalFavs get instance => _singleton;
  LocalFavs._();
  LocalFavModel favs = LocalFavModel(physicians: [], labs: [], pharmas: []);
  Future<void> initDatas() async {
    await getMode();
  }

  setMode(LocalFavModel localFavModel) async {
    favs = localFavModel;
    await storage.write(key: "favs", value: favs.toJson());
  }

  getMode() async {
    final val = (await storage.read(key: "favs"));
    if (!checkIsNull(val)) {
      favs = LocalFavModel.fromJson(val!);
    }
  }
}

class LocalFavModel {
  final List<int> physicians;
  final List<int> labs;
  final List<int> pharmas;
  LocalFavModel({
    required this.physicians,
    required this.labs,
    required this.pharmas,
  });

  LocalFavModel copyWith({
    List<int>? physicians,
    List<int>? labs,
    List<int>? pharma,
  }) {
    return LocalFavModel(
      physicians: physicians ?? this.physicians,
      labs: labs ?? this.labs,
      pharmas: pharma ?? pharmas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'physicians': physicians,
      'labs': labs,
      'pharmas': pharmas,
    };
  }

  factory LocalFavModel.fromMap(Map<String, dynamic> map) {
    return LocalFavModel(
      physicians: List<int>.from(map['physicians']),
      labs: List<int>.from(map['labs']),
      pharmas: List<int>.from(map['pharmas']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalFavModel.fromJson(String source) =>
      LocalFavModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'FavModel(physicians: $physicians, labs: $labs, pharmas: $pharmas)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalFavModel &&
        listEquals(other.physicians, physicians) &&
        listEquals(other.labs, labs) &&
        listEquals(other.pharmas, pharmas);
  }

  @override
  int get hashCode => physicians.hashCode ^ labs.hashCode ^ pharmas.hashCode;
}
