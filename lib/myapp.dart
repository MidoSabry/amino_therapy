import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'core/component/inspector/inspector_floation_button.dart';
import 'core/global/enums/global_enum.dart';
import 'core/services/base_network/network_lost/network_cubit.dart';
import 'core/services/flavorizer/flavors_managment.dart';
import 'core/services/route_manager/router_manager.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/theme/app_theme.dart';
import 'core/services/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // setSystemNavigationBarColor();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NetworkCubit(Connectivity())),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final themeData =
              themeMode == ThemeMode.dark
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme;

          return AnimatedTheme(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            data: themeData,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: MaterialApp.router(
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: '2P ERP',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: context.watch<ThemeCubit>().state,
                builder: (context, child) {
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;

                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness:
                          isDark ? Brightness.light : Brightness.dark,
                      systemNavigationBarColor:
                          isDark ? Colors.black : Colors.white,
                      systemNavigationBarIconBrightness:
                          isDark ? Brightness.light : Brightness.dark,
                    ),
                  );
                  return MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: const TextScaler.linear(1.0)),

                    child:
                        (FlavorsManagement
                                        .instance
                                        .getCurrentFlavor
                                        .flavorType ==
                                    FlavorsTypes.dev ||
                                FlavorsManagement
                                        .instance
                                        .getCurrentFlavor
                                        .flavorType ==
                                    FlavorsTypes.stage)
                            ? Stack(
                              children: [
                                child!,
                                const InspectorFloationButton(),
                              ],
                            )
                            : child!,
                  );
                },
                routerConfig: RouterManager().router,
              ),
            ),
          );
        },
      ),
    );
  }
}
