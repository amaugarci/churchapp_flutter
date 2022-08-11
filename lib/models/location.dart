import 'package:json_annotation/json_annotation.dart';
import 'package:thebibleapp/models/_parsers.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  String? id;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String pastor;
  @JsonKey(defaultValue: '')
  String phone;
  @JsonKey(defaultValue: '')
  String email;
  @JsonKey(defaultValue: '')
  String address;
  @JsonKey(defaultValue: '')
  String imageUrl;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;

  Location()
      : id = null,
        name = '',
        pastor = '',
        phone = '',
        email = '',
        address = '',
        imageUrl = '',
        timestampCreated = null;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this)..remove('id');
}
