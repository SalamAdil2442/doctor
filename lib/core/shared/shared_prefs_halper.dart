import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/account/model.dart';

class SharedPrefsHalper {
  final storage = const FlutterSecureStorage();
  static final SharedPrefsHalper _singleton = SharedPrefsHalper._();
  static SharedPrefsHalper get instance => _singleton;
  SharedPrefsHalper._();
  String lang = "en";
  UserModel? user;
  bool themeMode = false;

  Future<void> initDatas() async {
    await getLang();
    await getMode();
    await getName();
  }

  setUser(UserModel newValue) async {
    user = newValue;
    await storage.write(key: "name", value: user!.toJson());
  }

  getName() async {
    final val = (await storage.read(key: "name"));

    user = val == null ? null : UserModel.fromJson(val);
  }

  setMode(bool newValue) async {
    themeMode = newValue;
    await storage.write(key: "themeMode", value: themeMode.toString());
  }

  getMode() async {
    final val = (await storage.read(key: "themeMode"));

    themeMode = checkBool(val, def: false);
  }

  setAccount(AccountModel newValue) async {
    await storage.write(key: "account", value: newValue.toJson());
  }

  Future<AccountModel?> getAccount() async {
    final val = (await storage.read(key: "account"));
    logger(val);
    if (checkIsNull(val)) {
      return null;
    }
    return AccountModel.fromJson(val ?? "");
  }

  setLang(var newValue) async {
    lang = newValue;
    await storage.write(key: "lang", value: "$newValue");
  }

  getLang() async {
    lang = (await storage.read(key: "lang")) ?? "en";
  }

  Future<void> deleteAccount() async {
    await storage.delete(key: "account");
  }
}

class UserModel {
  final String name;
  final String uuid;
  UserModel({
    required this.name,
    required this.uuid,
  });

  UserModel copyWith({
    String? name,
    String? uuid,
  }) {
    return UserModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uuid': uuid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, uuid: $uuid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.name == name && other.uuid == uuid;
  }

  @override
  int get hashCode => name.hashCode ^ uuid.hashCode;
}
