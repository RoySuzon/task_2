import 'package:flutter/material.dart';
import 'package:task/features/auth/presentation/pages/login_screen.dart';
import 'package:task/features/dash_screen/data/model/user_model.dart';
import 'package:task/features/dash_screen/data/repo/dashboard_repo_imp.dart';
import 'package:task/features/dash_screen/domain/usecases/dashboard_use_case.dart';
import 'package:task/session_controller/session_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late UserModel userModel;
  bool isLoading = false;
  _getProfileData() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    DashboardUseCase useCase =
        DashboardUseCase(DashboardRepoImp(), SecureStorageSession());
    final res = await useCase.callGetUserData();

    res.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      userModel = r;
    });
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    _getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            drawer: Drawer(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () async {
                        final sessionManager = SecureStorageSession();

                        await sessionManager.clearSession();

                        Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      title: Text('Logout'),
                      leading: Icon(Icons.logout),
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(title: Text(userModel.data.email)),
            body: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(userModel.data.email),
                  ],
                )
              ],
            ),
          );
  }
}
