import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/repository/diary_repository.dart';

final MockDiaryRepositoryProvider = Provider<MockDiaryRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return MockDiaryRepository(dio, baseUrl: 'http://$ip/diary');
  },
);

class MockDiaryRepository extends DiaryRepositoryBase {
  MockDiaryRepository(Dio dio, {required String baseUrl});

  DiaryModel mockData = DiaryModel(id: "1", stickerInventory: [
    "1",
    "12",
    "21",
    "20",
    "8",
    "11",
    "24",
    "16",
    "3",
    "7",
    "14",
    "4",
    "10",
    "9",
    "19",
    "2",
    "22",
    "23",
    "15",
    "5",
    "18",
    "13",
    "6",
    "17"
  ], hitFavoriteList: {
    "1",
    "12",
    "20"
  });

  Future<DiaryModel> getDiaryModel() async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }
    return mockData;
  }
}

class MockDiaryRepositoryBase {}
