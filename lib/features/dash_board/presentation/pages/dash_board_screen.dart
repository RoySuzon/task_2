// ignore_for_file: deprecated_member_use

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
  late UserInfo userInfo;
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
      userInfo = r.userInfo;
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
            appBar: AppBar(title: Text("Profile")),
            body: ProfileScreen(
              userInfo: userInfo,
            ),
          );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userInfo});

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ProfilePic(image: userInfo.profilePicture, isShowPhotoUpload: false),
          Text(
            userInfo.fullName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Divider(height: 16.0 * 2),
          Info(
            infoKey: "User ID",
            info: userInfo.id,
          ),
          Info(
            infoKey: "Contact",
            info: userInfo.contact,
          ),
          Info(
            infoKey: "Email Address",
            info: userInfo.email,
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          if (isShowPhotoUpload)
            InkWell(
              onTap: imageUploadBtnPress,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
