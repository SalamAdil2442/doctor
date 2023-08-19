import 'dart:convert';

class Names {
  final String kurdish;
  final String arabic;
  final String english;
  Names({
    required this.kurdish,
    required this.arabic,
    required this.english,
  });

  Names copyWith({
    String? kurdish,
    String? arabic,
    String? english,
  }) {
    return Names(
      kurdish: kurdish ?? this.kurdish,
      arabic: arabic ?? this.arabic,
      english: english ?? this.english,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kurdish': kurdish,
      'arabic': arabic,
      'english': english,
    };
  }

  factory Names.fromMap(Map<String, dynamic> map) {
    return Names(
      kurdish: map['kurdish'] ?? "",
      arabic: map['arabic'] ?? "",
      english: map['english'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Names.fromJson(String source) =>
      Names.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Names(kurdish: $kurdish, arabic: $arabic, english: $english)';

  @override
  bool operator ==(covariant Names other) {
    if (identical(this, other)) return true;

    return other.kurdish == kurdish &&
        other.arabic == arabic &&
        other.english == english;
  }

  @override
  int get hashCode => kurdish.hashCode ^ arabic.hashCode ^ english.hashCode;
}
