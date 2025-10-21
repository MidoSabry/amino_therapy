import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'log/app_log.dart';

class DeviceInfoManager {
  DeviceInfoManager._privateConstructor();
  static final DeviceInfoManager instance =
      DeviceInfoManager._privateConstructor();
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  Future<void> init() async {
    if (Platform.isAndroid) {
      androidInfo = await _deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await _deviceInfoPlugin.iosInfo;
    }
  }

  /// Fetches the device name and ID, then returns them concatenated.
  String get getDeviceIdentity {
    String? deviceName = getDeviceName;
    String? deviceId = getDeviceId;
    AppLog.printValueAndTitle("Device name and id", "$deviceName - $deviceId");
    return "$deviceName - $deviceId";
  }

  /// Retrieves the device name based on platform.
  String? get getDeviceName {
    if (Platform.isAndroid) {
      return androidInfo?.model; // Example: "Samsung Galaxy S21"
    } else if (Platform.isIOS) {
      return iosInfo?.modelName != null
          ? iosInfo!.modelName
          : iosInfo?.utsname.machine; // Example: "iPhone14,2"
    }
    return null;
  }

  String? get getDeviceId {
    if (Platform.isAndroid) {
      return androidInfo?.id;
    } else if (Platform.isIOS) {
      return iosInfo?.identifierForVendor;
    }
    return null;
  }
}
