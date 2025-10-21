import 'dart:io';
import 'package:amino_therapy/core/extensions/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/button/p_button.dart';
import '../../component/text/p_text.dart';
import '../../data/constants/extra_constants.dart';
import '../../data/constants/global_obj.dart';
import '../../data/constants/shared_preferences_constants.dart';
import '../local_storage/shared_preference/shared_preference_service.dart';
import '../log/app_log.dart';

class AppStoreHandler {
  // Private constructor
  AppStoreHandler._();
  static final AppStoreHandler instance = AppStoreHandler._();

  String? currentAppStoreVersion;
  String? currentInstalledVersion;
  // Check if tere is new version available
  Future<bool> get isUpdateAvailable async {
    final Upgrader upgrader = Upgrader(
      debugDisplayAlways: true,
      debugLogging: true,
    );

    bool checkInit = await upgrader.initialize();

    bool isUpdateAvailable = upgrader.isUpdateAvailable();

    // Set current store version and installed version on the device
    currentAppStoreVersion = upgrader.currentAppStoreVersion;
    currentInstalledVersion = upgrader.currentInstalledVersion;

    if (Platform.isAndroid) {
      try {
        final AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();
        AppLog.logValueAndTitle("In app update", appUpdateInfo.toString());
        AppLog.logValueAndTitle(
          "In app update",
          appUpdateInfo.updateAvailability,
        );
        AppLog.logValueAndTitle(
          "In app update",
          appUpdateInfo.availableVersionCode,
        );

        currentAppStoreVersion = appUpdateInfo.availableVersionCode.toString();

        if (appUpdateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          isUpdateAvailable = true;
        }
      } catch (e) {
        AppLog.logValueAndTitle("Error from InAppUpdate package", e);
      }
    }

    AppLog.logValueAndTitle("Store version", upgrader.currentAppStoreVersion);
    AppLog.logValueAndTitle(
      "Installed version",
      upgrader.currentInstalledVersion,
    );

    AppLog.logValueAndTitle("Is update available?", isUpdateAvailable);
    if (!checkInit || currentAppStoreVersion!.isEmptyOrNull) {
      // If the initialization failed
      return false;
    }
    return isUpdateAvailable;
  }

  Future<dynamic> showUpdateDialog() async {
    return await showAdaptiveDialog(
      context: Get.navigatorState!.context,
      barrierDismissible: false,
      barrierLabel: "VersionCheck",
      builder: (context) => AppVersionDialogContent(
        currentVersion: currentInstalledVersion,
        newVersion: currentAppStoreVersion,
      ),
    );
  }

  void openStore() {
    if (Platform.isIOS) {
      final url = Uri.parse(ExtraConstants.appStoreUrl);
      launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // Update inside the app in case device is Android only

      //Perform flexible update
      InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
        if (appUpdateResult == AppUpdateResult.success) {
          //App Update successful
          InAppUpdate.completeFlexibleUpdate();
        }
      });
    }
  }

  void rateApp() async {
    String? dateFirstTimeOpen = SharedPreferenceService().getString(
      SharPrefConstants.dateFirstTimeOpenKey,
    );
    if (dateFirstTimeOpen.isEmpty) {
      await SharedPreferenceService().setString(
        SharPrefConstants.dateFirstTimeOpenKey,
        DateTime.now().toIso8601String(),
      );
    } else if (DateTime.parse(
      dateFirstTimeOpen,
    ).add(const Duration(days: 30)).isBefore(DateTime.now())) {
      final InAppReview inAppReview = InAppReview.instance;
      inAppReview.isAvailable().then((value) {
        if (value) {
          inAppReview.requestReview();
        }
      });
    }
  }
}

// ============ APP VERSION dialog ============ //
class AppVersionDialogContent extends StatelessWidget {
  final String? newVersion;
  final String? currentVersion;

  const AppVersionDialogContent({
    super.key,
    this.newVersion,
    this.currentVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔥 Animated Icon (pulse)
              const AppVersionIconWidget(),
              const SizedBox(height: 16),

              // Title
              PText(
                title: "updateAvailable".tr(),
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontColor: Theme.of(context).primaryColor,
              ),

              const SizedBox(height: 12),

              // Description
              PText(
                title: "newUpdateAvailableMsg".tr(),
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  PText(title: "currentVersion".tr()),
                  const SizedBox(width: 8),
                  PText(
                    title: currentVersion ?? '',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  PText(title: "newVersion".tr()),
                  const SizedBox(width: 8),
                  PText(title: newVersion ?? '', textAlign: TextAlign.center),
                ],
              ),

              const SizedBox(height: 24),

              PButton(
                isFitWidth: true,
                hasCubit: false,
                onPressed: AppStoreHandler.instance.openStore,
                title: "updateNow",
              ),
              // Action Button
              // Row(
              //   children: [
              //     Expanded(
              //       child: PButton(
              //         hasCubit: false,
              //         onPressed: AppStoreHandler.instance.openStore,
              //         title: "updateNow",
              //       ),
              //     ),
              //     const SizedBox(width: 12),
              //     Expanded(
              //       child: PButton(
              //         hasCubit: false,
              //         onPressed: Navigator.of(context).pop,
              //         title: "later",
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppVersionIconWidget extends StatefulWidget {
  const AppVersionIconWidget({super.key});

  @override
  State<AppVersionIconWidget> createState() => _AppVersionIconWidgetState();
}

class _AppVersionIconWidgetState extends State<AppVersionIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Icon(
        Icons.system_update,
        color: Theme.of(context).primaryColor,
        size: 80,
      ),
    );
  }
}
