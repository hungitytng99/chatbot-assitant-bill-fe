import 'package:json_annotation/json_annotation.dart';
part 'monthly_practice_entity.g.dart';

@JsonSerializable()
class MonthlyPracticeEntity {
  @JsonKey(name: "start_date")
  final String startDate;
  @JsonKey(name: "end_date")
  final String endDate;
  @JsonKey(name: "practice_date")
  final List<String> practiceDate;

  MonthlyPracticeEntity({
    required this.startDate,
    required this.endDate,
    required this.practiceDate,
  });

  MonthlyPracticeEntity copyWith({
    String? startDate,
    String? endDate,
    List<String>? practiceDate,
  }) {
    return MonthlyPracticeEntity(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      practiceDate: practiceDate ?? this.practiceDate,
    );
  }

  factory MonthlyPracticeEntity.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPracticeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyPracticeEntityToJson(this);
}
