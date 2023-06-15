// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => NewUser(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      password_confirm: json['password_confirm'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      bloodtype: json['bloodtype'] as String?,
      usertype: json['usertype'] as String?,
      address: json['address'] as String?,
      birthdate: json['birthdate'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      image: json['image'] as String?,
      worklocation: json['worklocation'] as String?,
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'password_confirm': instance.password_confirm,
      'email': instance.email,
      'gender': instance.gender,
      'bloodtype': instance.bloodtype,
      'usertype': instance.usertype,
      'address': instance.address,
      'birthdate': instance.birthdate,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image': instance.image,
      'worklocation': instance.worklocation,
    };
