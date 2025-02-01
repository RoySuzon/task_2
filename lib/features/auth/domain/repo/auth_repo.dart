import 'package:dartz/dartz.dart';
import 'package:task/core/error/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> login(
      {required String email, required String password});
}
