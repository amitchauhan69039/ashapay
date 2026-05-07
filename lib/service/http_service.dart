import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:asha_pay/asha_pay.dart';

class HttpService {

  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? headers,
    bool skipHeader = false,
    bool isContentType = false,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // 🔥 Default headers
      headers = headers ?? appHeader(isContentType: isContentType);

      // Auth Token
      String? token = PrefService.getString(PrefKeys.accessToken);
      if (token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }

      debugPrint("Url = $url");
      debugPrint("Headers = $headers");
      debugPrint("Query Params = $queryParams");

      Uri uri = Uri.parse(url);
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http.get(uri, headers: headers);

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint("ERROR: ${e.toString()}");
    }
    return null;
  }

  static Future<http.Response?> postApi({
    required String url,
    Map<String, String>? header,
    Map<String, dynamic>? body,
  }) async {
    try {
      header ??= {};

      header['Content-Type'] = 'application/json';
      header[' '] = 'application/json';

      // 🔥 Auth Token
      String? token = PrefService.getString(PrefKeys.accessToken);
      if (token.isNotEmpty) {
        header["Authorization"] = "Bearer $token";
      }
      
      debugPrint("URL = $url");
      debugPrint("HEADER = $header");
      debugPrint("BODY = ${jsonEncode(body)}");

      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));

      debugPrint("STATUS = ${response.statusCode}");
      debugPrint("RESPONSE = ${response.body}");

      return response;
    } catch (e, s) {
      debugPrint("ERROR = $e");
      debugPrint("STACK = $s");
      return null;
    }
  }

  static Future<http.Response?> uploadFileWithDataApi({
    required String url,
    Map<String, String>? header,
    dynamic body,
    String? requestType,
    List<FileModel> fileData = const [],
    bool isContentType = false,
  }) async {
    header = header ?? appHeader(isContentType: isContentType);
    debugPrint("Url = $url");
    debugPrint("Header = $header");
    debugPrint("Body = $body");
    debugPrint("fileData = $fileData");
    try {
      var request =
      http.MultipartRequest(requestType ?? "POST", Uri.parse(url));
      request.fields.addAll(body ?? {});
      request.headers.addAll(header);
      for (FileModel element in fileData) {
        if (element.file == null || element.keyName == null) {
          continue;
        }
        request.files.add(
          http.MultipartFile(
            element.keyName ?? '',
            File(element.file!.path).readAsBytes().asStream(),
            File(element.file!.path).lengthSync(),
            filename: getFileName(element.file!),
          ),
        );
      }

      final http.StreamedResponse streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      debugPrint(e.toString());
      // toastMsg(e.toString());
      return null;
    }
  }
  static Map<String, String> appHeader({bool isContentType = false}) {
    if (PrefService.getString(PrefKeys.accessToken).isEmpty) {
      return {
        if(isContentType)
          "Content-Type":"application/json",
          "Accept":"application/json"
      };
    } else {
      return {
        "token": PrefService.getString(PrefKeys.accessToken),
        if(isContentType)
          "Content-Type":"application/json",
          "Accept":"application/json"
      };
    }
  }

  static Future<bool> isTokenExpire(http.Response response) async {
    if (response.statusCode == 401) {
      await PrefService.set(PrefKeys.accessToken, "");
      await PrefService.set(PrefKeys.isLogin, false);
      //Get.offAll(() => LoginScreen());
      return true;
    } else {
      return false;
    }
  }

}
