import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  final ProjectStateKind projectStateKind;
  final String? projectName;
  final DateTime? startDate;
  final int? dayInARow;

  ProjectModel({
    required this.projectStateKind,
    this.projectName,
    this.startDate,
    this.dayInARow = 0,
  });

  ProjectModel copyWith({
    ProjectStateKind? projectStateKind,
    String? projectName,
    DateTime? startDay,
    int? dayInARow,
  }) {
    return ProjectModel(
      projectStateKind: projectStateKind ?? this.projectStateKind,
      projectName: projectName ?? this.projectName,
      startDate: startDay ?? this.startDate,
      dayInARow: dayInARow ?? this.dayInARow,
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}
