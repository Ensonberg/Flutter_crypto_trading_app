import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/colors/color_palette.dart';
import 'core/routes/router.dart';
import 'l10n/app_localizations.dart';

/// Main example app class
class RootApp extends ConsumerStatefulWidget {
  // final AudioHandler audioHandler;

  /// Default constructor for Example app
  const RootApp({super.key});

  @override
  ConsumerState<RootApp> createState() => _RootAppState();
}

class _RootAppState extends ConsumerState<RootApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      lightColorScheme = ColorPalette.darkColorScheme;
      darkColorScheme = ColorPalette.darkColorScheme;

      return ScreenUtilInit(
          designSize: const Size(414, 896),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          // splitScreenMode: true,
          builder: (child, widget) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: MaterialApp.router(
                // title: F.title,

                debugShowCheckedModeBanner: false,
                title: "RavenPay",
                theme: ThemeData(
                  useMaterial3: true,
                  fontFamily: "Satoshi",
                  brightness: Brightness.dark,
                  colorScheme: lightColorScheme,
                  // extensions: [lightCustomColors],
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  fontFamily: "Satoshi",
                  brightness: Brightness.dark,
                  colorScheme: darkColorScheme,
                  //  extensions: [darkCustomColors],
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
                routeInformationProvider: router.routeInformationProvider,
              ),
            );
          });
    }));
  }
}

// @immutable
// class CustomColors extends ThemeExtension<CustomColors> {
//   const CustomColors({
//     required this.danger,
//   });
//
//   final Color? danger;
//
//   @override
//   CustomColors copyWith({Color? danger}) {
//     return CustomColors(
//       danger: danger ?? this.danger,
//     );
//   }
//
//   @override
//   CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
//     if (other is! CustomColors) {
//       return this;
//     }
//     return CustomColors(
//       danger: Color.lerp(danger, other.danger, t),
//     );
//   }
//
//   CustomColors harmonized(ColorScheme dynamic) {
//     return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
//   }
// }
