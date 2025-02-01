import 'package:dartz/dartz.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/core/services/htpp_manager/http_manager.dart';
import 'package:task/features/dash_screen/data/model/user_model.dart';
import 'package:task/features/dash_screen/domain/repo/dash_board_repo.dart';
import 'package:task/session_controller/session_manage.dart';
import 'package:task/utils/api_end_point.dart';

class DashboardRepoImp implements DashBoardRepo {
  final HttpManager _httpManager = HttpManager();
  @override
  Future<Either<Failure, UserModel>> getUserData(
      SessionManager sessionManager) async {
    String? token = await sessionManager.getSession();

    Map<String, String> header = {"Authorization": "Bearer $token"};
    try {
      final res = await _httpManager
          .request(HttpMethod.GET, ApiEndPoint.userProfile, headers: header);
      if (res.statusCode == 200) {
        UserModel user = userModelFromJson(res.body);
        return Right(user);
      } else {
        return Left(Failure(
            "Something going wrong the statuscode id${res.statusCode}"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
