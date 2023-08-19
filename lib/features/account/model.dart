// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountModel {
  final String username;
  final String password;
  AccountModel({
    required this.username,
    required this.password,
  });

  AccountModel copyWith({
    String? username,
    String? password,
  }) {
    return AccountModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AccountModel(username: $username, password: $password)';

  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
