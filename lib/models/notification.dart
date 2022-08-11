import 'package:json_annotation/json_annotation.dart';
import 'package:thebibleapp/models/_parsers.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  String? id;
  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(defaultValue: '')
  String body;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;

  Notification()
      : id = null,
        title = '',
        body = '',
        timestampCreated = null;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this)..remove('id');
}
