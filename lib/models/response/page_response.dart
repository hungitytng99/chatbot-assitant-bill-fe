import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable()
class PageResponse {
  @JsonKey()
  int itemsPerPage;
  @JsonKey()
  int currentPage;
  @JsonKey()
  int toTalPage;
  @JsonKey()
  int toTalRecord;

  PageResponse({
    this.itemsPerPage = 0,
    this.currentPage = 1,
    this.toTalPage = 0,
    this.toTalRecord = 0,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);
}
