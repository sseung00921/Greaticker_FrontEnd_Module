import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';

final MockDiaryRepositoryReturningErrorProvider = Provider<MockDiaryRepositoryReturingError>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockDiaryRepositoryReturingError(dio, baseUrl: 'http://$ip/diary');
  },
);

class MockDiaryRepositoryReturingError extends DiaryRepositoryBase{
  MockDiaryRepositoryReturingError(Dio dio, {required String baseUrl});

  Future<DiaryModel> getDiaryModel() async {
    throw Exception();
  }
}
