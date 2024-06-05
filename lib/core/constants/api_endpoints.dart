class ApiEndPoints {
  static const String baseUrl = "https://morphmydesign.com";

  static const String login = "/api/auth/login";
  static const String logout = "/api/auth/logout";
  static const String signUp = "/api/auth/register";
  static const String otpVerify = "/api/auth/otp-validation";
  static const String resendOtp = "/api/auth/resend-otp";
  static const String forgotPasswordReq = "/api/auth/recovery";
  static const String resetPassword = "/api/auth/password/reset";
  static const String forgotPasswordOtp = "/api/auth/password/otp-validation";

  static const String getEvents = "/api/host/event/my-events";
  static const String createEvent = "/api/host/event/create";
  static const String uploadBanner = "/api/host/event/upload-banner-file";
  static const String eventBannerAttach = "/api/host/event/add-invitaiton-banner";

  static const String addGuest = "/api/host/guest/create";

  static const String getProfile = '/api/profile/get-user-profile';
  static const String profileUpdate = '/api/profile/update-user-profile/';



  static const String googleMapApiKey = "AIzaSyAf2G8a7vc1KmomzlDkeg3kmy9Fw35tSEs";

}
