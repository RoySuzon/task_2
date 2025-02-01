import 'package:dartz/dartz.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/features/dash_board/data/model/user_model.dart';
import 'package:task/session_controller/session_manage.dart';

abstract class DashBoardRepo {
  Future<Either<Failure, UserModel>> getUserData(SessionManager sessionManager);
}
