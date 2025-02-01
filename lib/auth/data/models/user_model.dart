import 'dart:convert';
import 'package:task/auth/domain/enties/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEnitiy {
  UserModel(
      {required super.userInfo,
      required super.token,
      required super.tokenType,
      required super.expiresIn});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userInfo: UserInfo.fromJson(json["userInfo"]),
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "userInfo": userInfo.toJson(),
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}

class UserInfo {
  String fullName;
  String normalizedName;
  String normalizedUserName;
  dynamic lockoutEnd;
  String normalizedEmail;
  String normalizedPassword;
  String id;
  String userName;
  String email;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  bool lockoutEnabled;
  int accessFailedCount;

  UserInfo({
    required this.fullName,
    required this.normalizedName,
    required this.normalizedUserName,
    required this.lockoutEnd,
    required this.normalizedEmail,
    required this.normalizedPassword,
    required this.id,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        fullName: json["fullName"],
        normalizedName: json["normalizedName"],
        normalizedUserName: json["normalizedUserName"],
        lockoutEnd: json["lockoutEnd"],
        normalizedEmail: json["normalizedEmail"],
        normalizedPassword: json["normalizedPassword"],
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "normalizedName": normalizedName,
        "normalizedUserName": normalizedUserName,
        "lockoutEnd": lockoutEnd,
        "normalizedEmail": normalizedEmail,
        "normalizedPassword": normalizedPassword,
        "id": id,
        "userName": userName,
        "email": email,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}
