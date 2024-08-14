import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/constants/runtime.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/diary/model/diary_model.dart';


final MockDiaryRepositoryProvider = Provider<MockDiaryRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return MockDiaryRepository(dio, baseUrl: 'http://$ip/diary');
  },
);

class MockDiaryRepository {
  MockDiaryRepository(Dio dio, {required String baseUrl});


  DiaryModel mockData = DiaryModel(id: "1", stickerInventory: List<String>.generate(30, (index) => (index + 1).toString()),);


  Future<DiaryModel> getDiaryModel ({required String userId}) async {
    if (dotenv.get(ENVIRONMENT) == PROD) {
      await Future.delayed(Duration(seconds: 1));
    }

    return mockData;
  }
}





