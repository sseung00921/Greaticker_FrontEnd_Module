import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/data.dart';
import 'package:greaticker/common/dio/dio.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/diary/model/diary_model.dart';
import 'package:greaticker/diary/model/request_dto/diary_model_request_dto.dart';
import 'package:greaticker/diary/model/request_dto/hit_favorite_to_sticker_reqeust_dto.dart';
import 'package:greaticker/diary/model/hit_favorite_sticker_model.dart';
import 'package:retrofit/retrofit.dart';

part 'diary_repository.g.dart';

final DiaryRepositoryProvider = Provider<DiaryRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return DiaryRepository(dio, baseUrl: 'https://$ip/diary');
  },
);

// http://$ip/product
@RestApi()
abstract class DiaryRepository extends DiaryRepositoryBase{
  factory DiaryRepository(Dio dio, {String baseUrl}) = _DiaryRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<DiaryModel>> getDiaryModel();

  @POST('/re-order')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<String>> updateDiaryModel({@Body() required DiaryModelRequestDto diaryModelRequestDto});

  @POST('/hit-favorite')
  @Headers({'accessToken': 'true'})
  @override
  Future<ApiResponse<HitFavoriteStickerModel>> hitFavoriteToSticker({@Body() required HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto});

}

abstract class DiaryRepositoryBase {

  Future<ApiResponse<DiaryModel>> getDiaryModel();
  Future<ApiResponse<String>> updateDiaryModel({required DiaryModelRequestDto diaryModelRequestDto});
  Future<ApiResponse<HitFavoriteStickerModel>> hitFavoriteToSticker({required HitFavoriteToStickerReqeustDto hitFavoriteToStickerReqeustDto});
}