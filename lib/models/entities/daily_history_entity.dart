import 'package:ihz_bql/models/entities/daily_actions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_history_entity.g.dart';

@JsonSerializable()
class DailyHistoryEntity {
  @JsonKey()
  final String? date;

  @JsonKey()
  final List<DailyActionEntity>? actions;

  DailyHistoryEntity({
    required this.date,
    required this.actions,
  });

  DailyHistoryEntity copyWith({
    String? date,
    List<DailyActionEntity>? actions,
  }) {
    return DailyHistoryEntity(
      date: date ?? this.date,
      actions: actions ?? this.actions,
    );
  }

  factory DailyHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$DailyHistoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DailyHistoryEntityToJson(this);
}
