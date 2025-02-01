// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:task/features/auth/domain/repo/auth_repo.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/core/services/htpp_manager/http_manager.dart';
import 'package:task/session_controller/session_manage.dart';
import 'package:task/utils/api_end_point.dart';

class AuthRepoImp implements AuthRepo {
  final HttpManager _httpManager = HttpManager();

  final SessionManager sessionManager;
  AuthRepoImp({
    required this.sessionManager,
  });

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password};
      final res = await _httpManager
          .request(HttpMethod.POST, ApiEndPoint.signInApi, body: body);

      if (res.statusCode == 200) {
        final accessToken = jsonDecode(res.body)['data']['accessToken'];
        await sessionManager.saveSession(accessToken);
        // await sessionManager.clearSession();
        // final session = await sessionManager.getSession();

        // log(session ?? "");
        return Right(true);
      } else {
        return left(Failure(jsonDecode(res.body)['message']));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
