
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';


abstract class BaseModel {
  final DateTime createdDateTime;
  final DateTime updatedDateTime;

  BaseModel({
    required this.createdDateTime,
    required this.updatedDateTime,
  });

}
