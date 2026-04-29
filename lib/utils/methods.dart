import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:asha_pay/asha_pay.dart';

Future<void> loadNetworkImage(String image) async {
  await loadAppImage(NetworkImage(image));
}

Future<void> loadAppImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    debugPrint("Image ${image.debugLabel} finished loading");
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}

 const platform = MethodChannel('device_id');

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "unknown";
  }
  return "unknown";
}
Future<String> getVersionCode() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  } catch (e) {
    print(e.toString());
  }
  return "";
}

Future<String?> getVersionString() async {
  try {
    final result = await PackageInfo.fromPlatform();
    return "${result.version} (${result.buildNumber})";
  } catch (e) {
    // catchToast(e.toString());
  }
  return null;
}

Future<String?> getOSVersionString() async {
  try {
    if (Platform.isAndroid) {
      final result = await DeviceInfoPlugin().androidInfo;
      return "Android (${result.model})";
    } else {
      final result = await DeviceInfoPlugin().iosInfo;
      return "iOS (${result.utsname.machine})";
    }
  } catch (e) {
    // catchToast(e.toString());
  }
  return null;
}

String getFileName(File file) {
  return basename(file.path);
}

Future<void> storeImgInCache(String? imageUrl) async {
  if (imageUrl == null) {
    return;
  }
  try {
    await DefaultCacheManager().downloadFile(
      imageUrl,
    );
  } catch (e) {
    print("errorImage=>${e.toString()}");
  // catchToast(e.toString());
  }

}

