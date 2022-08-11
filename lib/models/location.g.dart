// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location()
  ..id = json['id'] as String?
  ..name = json['name'] as String? ?? ''
  ..pastor = json['pastor'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..address = json['address'] as String? ?? ''
  ..imageUrl = json['imageUrl'] as String? ?? ''
  ..timestampCreated = parseToDateTime(json['timestampCreated']);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pastor': instance.pastor,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
    };
