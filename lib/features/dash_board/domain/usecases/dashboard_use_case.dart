// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/features/dash_screen/data/model/user_model.dart';
import 'package:task/features/dash_screen/domain/repo/dash_board_repo.dart';
import 'package:task/session_controller/session_manage.dart';

class DashboardUseCase {
  final DashBoardRepo repo;
  final SessionManager sessionManager;
  DashboardUseCase(this.repo, this.sessionManager);

  Future<Either<Failure, UserModel>> callGetUserData() async {
    return await repo.getUserData(sessionManager);
  }
}
