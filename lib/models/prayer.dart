import 'package:json_annotation/json_annotation.dart';
import 'package:thebibleapp/models/_parsers.dart';

part 'prayer.g.dart';

@JsonSerializable(explicitToJson: true)
class Prayer {
  String? id;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String email;
  @JsonKey(defaultValue: '')
  String phone;
  @JsonKey(defaultValue: '')
  String message;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;

  Prayer()
      : id = null,
        name = '',
        email = '',
        phone = '',
        message = '',
        timestampCreated = null;

  factory Prayer.fromJson(Map<String, dynamic> json) => _$PrayerFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerToJson(this)..remove('id');
}
