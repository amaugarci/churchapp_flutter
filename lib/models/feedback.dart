import 'package:json_annotation/json_annotation.dart';

import '_parsers.dart';

part 'feedback.g.dart';

@JsonSerializable(explicitToJson: true)
class Feedback {
  String? id;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String phone;
  @JsonKey(defaultValue: '')
  String email;
  @JsonKey(defaultValue: '')
  String message;
  @JsonKey(defaultValue: '')
  String userId;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampUpdated;

  Feedback()
      : name = '',
        phone = '',
        userId = '',
        email = '',
        timestampCreated = DateTime.now(),
        message = '';

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this)..remove('id');
}
