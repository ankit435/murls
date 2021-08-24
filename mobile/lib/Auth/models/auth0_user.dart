import 'package:json_annotation/json_annotation.dart';

part 'auth0_user.g.dart';

@JsonSerializable()
class Auth0User {
  Auth0User({
    required this.nickname,
    required this.name,
    required this.email,
    required this.picture,
    required this.updatedAt,
    required this.sub,
    // required this.family_name,
    // required this.given_name,
  });

  bool get hasImage => picture.isNotEmpty;

  final String nickname;
  final String name;
  final String picture;

  @JsonKey(name: 'updated_at')
  final String updatedAt;
  String get id => sub.split('|').join('');
  final String sub;

  final String email;
  // final String given_name;
  // final String family_name;

  factory Auth0User.fromJson(Map<String, dynamic> json) =>
      _$Auth0UserFromJson(json);

  Map<String, dynamic> toJson() => _$Auth0UserToJson(this);
}
