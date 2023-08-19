// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';

class WorkTime {
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;
  final bool isOpen24;
  WorkTime({
    this.openTime,
    required this.isOpen24,
    this.closeTime,
  });

  WorkTime copyWith({
    bool? isOpen24,
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
  }) {
    return WorkTime(
      isOpen24: isOpen24 ?? this.isOpen24,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isOpen24': isOpen24,
      'openTime': formatTime(openTime),
      'closeTime': formatTime(closeTime),
    };
  }

  factory WorkTime.fromMap(Map<String, dynamic> map) {
    return WorkTime(
        isOpen24: checkBool(map['isOpen24']),
        openTime: getTimeOfDay(map['openTime']),
        closeTime: getTimeOfDay(map['closeTime']));
  }

  String toJson() => json.encode(toMap());

  factory WorkTime.fromJson(String source) =>
      WorkTime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WorkTime(openTime: $openTime,isOpen24: $isOpen24, closeTime: $closeTime)';

  @override
  bool operator ==(covariant WorkTime other) {
    if (identical(this, other)) return true;

    return other.openTime == openTime &&
        other.closeTime == closeTime &&
        other.isOpen24 == isOpen24;
  }

  @override
  int get hashCode =>
      openTime.hashCode ^ closeTime.hashCode ^ isOpen24.hashCode;
}
