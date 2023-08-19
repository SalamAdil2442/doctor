// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Days {
  static String sat = "sat";
  static String sun = "sun";
  static String mon = "mon";
  static String tues = "tues";
  static String wed = "wed";
  static String thu = "thu";
  static String fri = "fri";
  static List<String> get all => [
        sat,
        sun,
        mon,
        tues,
        wed,
        thu,
        fri,
      ];
}

class DayClass {
  final bool sat;
  final bool sun;
  final bool mon;
  final bool tues;
  final bool wed;
  final bool thu;
  final bool fri;
  DayClass({
    required this.sat,
    required this.sun,
    required this.mon,
    required this.tues,
    required this.wed,
    required this.thu,
    required this.fri,
  });

  DayClass copyWith({
    bool? sat,
    bool? sun,
    bool? mon,
    bool? tues,
    bool? wed,
    bool? thu,
    bool? fri,
  }) {
    return DayClass(
      sat: sat ?? this.sat,
      sun: sun ?? this.sun,
      mon: mon ?? this.mon,
      tues: tues ?? this.tues,
      wed: wed ?? this.wed,
      thu: thu ?? this.thu,
      fri: fri ?? this.fri,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sat': sat,
      'sun': sun,
      'mon': mon,
      'tues': tues,
      'wed': wed,
      'thu': thu,
      'fri': fri,
    };
  }

  factory DayClass.fromMap(Map<String, dynamic> map) {
    return DayClass(
      sat: map['sat'] as bool,
      sun: map['sun'] as bool,
      mon: map['mon'] as bool,
      tues: map['tues'] as bool,
      wed: map['wed'] as bool,
      thu: map['thu'] as bool,
      fri: map['fri'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayClass.fromJson(String source) =>
      DayClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DayClass(sat: $sat, sun: $sun, mon: $mon, tues: $tues, wed: $wed, thu: $thu, fri: $fri)';
  }

  @override
  bool operator ==(covariant DayClass other) {
    if (identical(this, other)) return true;

    return other.sat == sat &&
        other.sun == sun &&
        other.mon == mon &&
        other.tues == tues &&
        other.wed == wed &&
        other.thu == thu &&
        other.fri == fri;
  }

  @override
  int get hashCode {
    return sat.hashCode ^
        sun.hashCode ^
        mon.hashCode ^
        tues.hashCode ^
        wed.hashCode ^
        thu.hashCode ^
        fri.hashCode;
  }
}
