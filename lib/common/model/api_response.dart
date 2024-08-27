import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

abstract class ApiResponseBase {}

class ApiResponseError extends ApiResponseBase {
  final String message;

  ApiResponseError({
    required this.message,
  });
}

class ApiResponseLoading extends ApiResponseBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class ApiResponse<T> extends ApiResponseBase{
  final bool isSuccess;
  final String? message;
  T? data;

  ApiResponse({
    required this.isSuccess,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}