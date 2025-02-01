class ApiEndPoint {
  static final String _basUer = "https://api.pentagoncare.online";

  //Sign In End-Poin
  static String get signInApi => "$_basUer/api/v1/auth/sign-in";

  //userProdile  End-Poin
  static String get userProfile => "$_basUer/api/v1/user/profile";
}
