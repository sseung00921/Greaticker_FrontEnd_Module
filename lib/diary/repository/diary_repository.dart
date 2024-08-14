import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:retrofit/retrofit.dart';

part 'diary_repository.g.dart';

final DiaryRepositoryProvider = Provider<DiaryRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return DiaryRepository(dio, baseUrl: 'http://$ip/diary');
  },
);

// http://$ip/product
@RestApi()
abstract class DiaryRepository {
  factory DiaryRepository(Dio dio, {String baseUrl}) = _DiaryRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<DiaryModel> getDiaryModel({
    @Query('userId') required String userId
  });
}

