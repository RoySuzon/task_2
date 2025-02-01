
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool success;
    String message;
    Data data;

    UserModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String firstName;
    String lastName;
    String email;
    String contact;
    String profilePicture;
    List<dynamic> document;
    String role;
    String fcmToken;
    bool isActive;
    bool isDelete;
    String status;
    Validation validation;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<dynamic> shifts;

    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.contact,
        required this.profilePicture,
        required this.document,
        required this.role,
        required this.fcmToken,
        required this.isActive,
        required this.isDelete,
        required this.status,
        required this.validation,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.shifts,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        contact: json["contact"],
        profilePicture: json["profilePicture"],
        document: List<dynamic>.from(json["document"].map((x) => x)),
        role: json["role"],
        fcmToken: json["fcmToken"],
        isActive: json["isActive"],
        isDelete: json["isDelete"],
        status: json["status"],
        validation: Validation.fromJson(json["validation"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        shifts: List<dynamic>.from(json["shifts"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "contact": contact,
        "profilePicture": profilePicture,
        "document": List<dynamic>.from(document.map((x) => x)),
        "role": role,
        "fcmToken": fcmToken,
        "isActive": isActive,
        "isDelete": isDelete,
        "status": status,
        "validation": validation.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "shifts": List<dynamic>.from(shifts.map((x) => x)),
    };
}

class Validation {
    bool isVerified;

    Validation({
        required this.isVerified,
    });

    factory Validation.fromJson(Map<String, dynamic> json) => Validation(
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "isVerified": isVerified,
    };
}
