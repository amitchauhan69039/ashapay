import 'package:asha_pay/asha_pay.dart';

class AuthApi{

  static Future<LoginModel?> userLogin(Map<String, String> loginBody) async {
    try {
      final response = await HttpService.postApi(
        url: EndPoints.login,
        isContentType: true,
        body: loginBody
      );
      print("loginBody: $loginBody");
      print("login: ${response?.body}");
      print("login: ${response}");

      if (response != null && response.statusCode == 200) {
        final responseBody = response.body;
        try {
          LoginModel model = loginModelFromJson(responseBody);
          return model;
        } catch (e) {
          throw Exception("Unexpected response format: $responseBody");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

}
