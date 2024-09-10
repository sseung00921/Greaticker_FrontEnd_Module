import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/model/cursor_pagination_model.dart';
import 'package:greaticker/common/model/model_with_id.dart';
import 'package:greaticker/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId>{
  Future<ApiResponse<CursorPagination<T>>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}