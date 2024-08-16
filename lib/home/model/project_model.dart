import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';
abstract class ProjectModelBase {}

class ProjectModelError extends ProjectModelBase {
  final String message;

  ProjectModelError({
    required this.message,
  });
}

class ProjectModelLoading extends ProjectModelBase {}

@JsonSerializable()
class ProjectModel extends ProjectModelBase implements IModelWithId   {
  final String id;
  final ProjectStateKind projectStateKind;
  final String? projectName;
  final DateTime? startDay;
  final int? dayInARow;

  ProjectModel({
    required this.id,
    required this.projectStateKind,
    this.projectName,
    this.startDay,
    this.dayInARow,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}
