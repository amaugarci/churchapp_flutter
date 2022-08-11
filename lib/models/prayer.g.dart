// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prayer _$PrayerFromJson(Map<String, dynamic> json) => Prayer()
  ..id = json['id'] as String?
  ..name = json['name'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..message = json['message'] as String? ?? ''
  ..timestampCreated = parseToDateTime(json['timestampCreated']);

Map<String, dynamic> _$PrayerToJson(Prayer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'message': instance.message,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
    };
