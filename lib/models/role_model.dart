// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  List<RoleElement> roles;

  RoleModel({
    required this.roles,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        roles: List<RoleElement>.from(
            json["roles"].map((x) => RoleElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class RoleElement {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String usersCount;
  List<User> users;

  RoleElement({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.usersCount,
    required this.users,
  });

  factory RoleElement.fromJson(Map<String, dynamic> json) => RoleElement(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        usersCount: json["users_count"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "users_count": usersCount,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  int id;
  String name;
  String email;
  String? image;
  dynamic emailVerifiedAt;
  String roleId;
  String? createdAt;
  String updatedAt;
  UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role: UserRole.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role": role.toJson(),
      };
}

class UserRole {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  UserRole({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
