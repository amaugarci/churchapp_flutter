import 'package:json_annotation/json_annotation.dart';
import 'package:thebibleapp/models/_parsers.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  String? id;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String description;
  @JsonKey(defaultValue: '')
  String location;
  @JsonKey(defaultValue: '')
  String imageUrl;
  @JsonKey(defaultValue: '')
  String link;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? eventDate;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;

  Event()
      : id = null,
        name = '',
        description = '',
        location = '',
        imageUrl = '',
        link = '',
        eventDate = null,
        timestampCreated = null;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this)..remove('id');
}
