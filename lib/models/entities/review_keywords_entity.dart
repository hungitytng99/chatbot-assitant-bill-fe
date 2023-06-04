import 'package:json_annotation/json_annotation.dart';
part 'review_keywords_entity.g.dart';

@JsonSerializable()
class ReviewKeywordsEntity {
  @JsonKey()
  final List<String> keywords;

  ReviewKeywordsEntity({
    required this.keywords,
  });

  ReviewKeywordsEntity copyWith({
    List<String>? keywords,
  }) {
    return ReviewKeywordsEntity(
      keywords: keywords ?? this.keywords,
    );
  }

  factory ReviewKeywordsEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewKeywordsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewKeywordsEntityToJson(this);
}
