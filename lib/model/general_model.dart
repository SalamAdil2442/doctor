// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/model/days_model.dart';
import 'package:tandrustito/model/names_model.dart';
import 'package:tandrustito/views/time.dart';

class GeneralModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        specialiestId,
        name,
        email,
        phone,
        mobile,
        address,
        about,
        latitude,
        longitude,
        city,
        rate,
        availableDays,
        workingHours,
        isAdd,
        image
      ];

  final int id;
  final int specialiestId;
  final Names name;
  final String email;
  final String? city;
  final String phone;
  final String mobile;
  final Names address;
  final Names about;
  final double latitude;
  final double longitude;
  final num rate;
  final DayClass availableDays;
  final WorkTime workingHours;
  final bool isAdd;
  final String? image;
  const GeneralModel({
    required this.id,
    required this.specialiestId,
    required this.name,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.address,
    required this.about,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.rate,
    required this.availableDays,
    required this.workingHours,
    required this.isAdd,
    this.image,
  });

  GeneralModel copyWith({
    int? id,
    int? specialiestId,
    Names? name,
    String? email,
    String? phone,
    String? city,
    String? mobile,
    Names? address,
    Names? about,
    double? latitude,
    double? longitude,
    String? websit,
    num? rate,
    DayClass? availableDays,
    WorkTime? workingHours,
    bool? isAdd,
    String? image,
  }) {
    return GeneralModel(
      specialiestId: specialiestId ?? this.specialiestId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      city: city ?? this.city,
      about: about ?? this.about,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rate: rate ?? this.rate,
      availableDays: availableDays ?? this.availableDays,
      workingHours: workingHours ?? this.workingHours,
      isAdd: isAdd ?? this.isAdd,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toJson(),
      'email': email,
      'city': city,
      'phone': phone,
      'specialiestId': specialiestId,
      'mobile': mobile,
      'address': address.toJson(),
      'about': about.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'rate': rate,
      'availableDays': availableDays.toJson(),
      'workingHours': workingHours.toJson(),
      'isAdd': isAdd,
      'image': image,
    };
  }

  factory GeneralModel.fromMap(Map<String, dynamic> map) {
    return GeneralModel(
      id: map['id'],
      specialiestId: map['specialiestId'] ?? 0,
      name: Names.fromJson(map['name']),
      email: map['email'],
      city: map['city'],
      phone: map['phone'],
      mobile: map['mobile'],
      address: Names.fromJson(map['address']),
      about: Names.fromJson(map['about']),
      latitude: checkDouble(map['latitude']),
      longitude: checkDouble(map['longitude']),
      rate: map['rate'] as num,
      availableDays: DayClass.fromJson(map['availableDays']),
      workingHours: WorkTime.fromJson(map['workingHours']),
      isAdd: checkBool(map['isAdd']),
      image: formatAttachment(map['image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralModel.fromJson(String source) =>
      GeneralModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewDoctor(city:$city ,id: $id,specialiestId:$specialiestId, name: $name, email: $email, phone: $phone, mobile: $mobile, address: $address, about: $about, latitude: $latitude, longitude: $longitude, rate: $rate, availableDays: $availableDays, workingHours: $workingHours, isAdd: $isAdd, image: $image)';
  }

  @override
  bool operator ==(covariant GeneralModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.mobile == mobile &&
        other.city == city &&
        other.address == address &&
        other.about == about &&
        other.specialiestId == specialiestId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.rate == rate &&
        other.availableDays == availableDays &&
        other.workingHours == workingHours &&
        other.isAdd == isAdd &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        mobile.hashCode ^
        address.hashCode ^
        specialiestId.hashCode ^
        city.hashCode ^
        about.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        rate.hashCode ^
        availableDays.hashCode ^
        workingHours.hashCode ^
        isAdd.hashCode ^
        image.hashCode;
  }
}
