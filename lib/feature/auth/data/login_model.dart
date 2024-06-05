class LoginModel {
  bool success;
  Data data;
  String message;

  LoginModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );


}

class Data {
  bool emailExist;
  String? accessToken;
  User user;

  Data({
    required this.emailExist,
     this.accessToken,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        emailExist: json["email_exist"],
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );


}

class User {
  int id;
  String email;
  String? phone;
  String firstName;
  String lastName;
  String username;
  String? avatar;
  bool acceptTerms;
  List<String> roles;
  bool otpVerified;

  User(
      {required this.id,
      required this.email,
      this.phone,
      required this.firstName,
      required this.lastName,
      required this.username,
      this.avatar,
      required this.acceptTerms,
      required this.roles,
      required this.otpVerified});

  factory User.fromJson(Map<String, dynamic> json) => User(
        otpVerified: json["OTP_verified"],
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        avatar: json["avatar"],
        acceptTerms: json["accept_terms"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );


}
