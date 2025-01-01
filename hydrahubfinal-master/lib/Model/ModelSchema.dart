
import 'dart:io';

class UserModel{
  final String? userID;
  final String? userEmail;
  final String? userName;
  final String userPassword;
  /*final String? userRole;
  final File? userImage;
  final String? getImage;
  final String? userAge;
  final String? userGender;
  final String? userPhone;

  final bool? userStatus;
  final String? createdAt;
  */

  UserModel(
      {this.userID,
        this.userName,
        this.userEmail,
        required this.userPassword,
        });
}