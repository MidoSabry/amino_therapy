import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'core/services/localization/app_localization.dart';
import 'di.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependencies().initialize();

  // // Request Notifications permisson
  // await NotificationsServices.instance.requestPermission();
  // await NotificationsServices.instance.getToken();

  // // Handle firebase background notifications
  // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.getSupportedLocales,
      fallbackLocale: AppLocalization.fallbackLocale,
      path: AppLocalization.getPath,
      startLocale: AppLocalization.startLocale,
      saveLocale: true,
      child: Sizer(
        builder: (p0, p1, p2) {
          return const MyApp();
        },
      ),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    // This enable showing status bar and the bottom bar of the device itself
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black, // ✅ Force black bottom bar
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  });

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //      builder: (context) => EasyLocalization(
  //       supportedLocales: AppLocalization.getSupportedLocales,
  //       fallbackLocale: AppLocalization.fallbackLocale,
  //       path: AppLocalization.getPath,
  //       startLocale: AppLocalization.startLocale,
  //       child: Sizer(
  //         builder: (p0, p1, p2) {
  //           return const MyApp();
  //         },
  //       ),
  //     ),
  //   ),
  // );
}
