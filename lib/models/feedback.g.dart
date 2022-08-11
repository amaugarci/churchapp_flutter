// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback()
  ..id = json['id'] as String?
  ..name = json['name'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..message = json['message'] as String? ?? ''
  ..userId = json['userId'] as String? ?? ''
  ..timestampCreated = parseToDateTime(json['timestampCreated'])
  ..timestampUpdated = parseToDateTime(json['timestampUpdated']);

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'message': instance.message,
      'userId': instance.userId,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
      'timestampUpdated': parseToDateTime(instance.timestampUpdated),
    };
