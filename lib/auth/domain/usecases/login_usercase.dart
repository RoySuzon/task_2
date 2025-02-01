import 'package:dartz/dartz.dart';
import 'package:shampan_audit/core/error/failure.dart';
import 'package:shampan_audit/features/auth/domain/enties/user_entity.dart';
import 'package:shampan_audit/features/auth/domain/repo/auth_repo.dart';

class LoginUserCase {
  final AuthRepo repo;
  LoginUserCase(this.repo);

  Future<Either<Failure, UserEnitiy>> loginExecute(
      String email, String password) async {
    return await repo.login(email: email, password: password);
  }
}
