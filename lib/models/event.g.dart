// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event()
  ..id = json['id'] as String?
  ..name = json['name'] as String? ?? ''
  ..description = json['description'] as String? ?? ''
  ..location = json['location'] as String? ?? ''
  ..imageUrl = json['imageUrl'] as String? ?? ''
  ..link = json['link'] as String? ?? ''
  ..eventDate = parseToDateTime(json['eventDate'])
  ..timestampCreated = parseToDateTime(json['timestampCreated']);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'link': instance.link,
      'eventDate': parseToDateTime(instance.eventDate),
      'timestampCreated': parseToDateTime(instance.timestampCreated),
    };
