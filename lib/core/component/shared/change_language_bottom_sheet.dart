import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/assets_helper/app_icon.dart';
import '../../services/localization/app_localization.dart';
import '../image/p_image.dart';

class ChangeLanguageContentForBottomSheet extends StatelessWidget {
  const ChangeLanguageContentForBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text('changeLanguage'.tr()),
        ),
        const Divider(),

        // Arabic Option
        ListTile(
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: PImage(
              source: AppIcons.saLang,
              width: 40,
              height: 40,
              isCircle: true,
            ),
          ),
          title: const Text('العربية'),
          trailing:
              AppLocalization.isArabic
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
          onTap: () async {
            await context.setLocale(const Locale('ar', 'SA'));
            Navigator.pop(context);
          },
        ),

        // English Option
        ListTile(
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: PImage(
              source: AppIcons.ukLang,
              width: 40,
              height: 40,
              isCircle: true,
            ),
          ),
          title: const Text('English'),
          trailing:
              context.locale.languageCode == 'en'
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
          onTap: () async {
            await context.setLocale(const Locale('en', 'US'));

            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
