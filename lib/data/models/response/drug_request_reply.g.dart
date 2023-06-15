// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_request_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugRequestReply _$DrugRequestReplyFromJson(Map<String, dynamic> json) =>
    DrugRequestReply(
      json['pharmacy_description'] as String?,
      json['isAlternative'] as bool?,
      json['pharmacy_phone'] as String?,
    );

Map<String, dynamic> _$DrugRequestReplyToJson(DrugRequestReply instance) =>
    <String, dynamic>{
      'pharmacy_description': instance.pharmacy_description,
      'isAlternative': instance.isAlternative,
      'pharmacy_phone': instance.pharmacy_phone,
    };
