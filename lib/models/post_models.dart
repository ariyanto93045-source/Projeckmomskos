import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart';

@JsonSerializable()
class PostModels {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModels.fromJson(Map<String, dynamic> json) =>
      _$PostModelsFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelsToJson(this);
}
