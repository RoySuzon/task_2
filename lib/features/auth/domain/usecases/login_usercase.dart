import 'package:flutter/material.dart';
import 'package:task/features/auth/domain/repo/auth_repo.dart';

class LoginUserCase {
  final AuthRepo repo;
  LoginUserCase(this.repo);

  Future<bool> loginExecute(BuildContext context,
      {required String email, required String password}) async {
    final login = await repo.login(email: email, password: password);
    return login.fold(
      (l) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
              SnackBar(content: Text(l.message), backgroundColor: Colors.red));
        return false;
      },
      (r) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Successfully Logged In!'),
            backgroundColor: Colors.green,
          ));
        return true;
      },
    );
  }
}
