import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:verbose_share_world/app_theme/app_theme.dart';
import 'package:verbose_share_world/auth/login_navigator.dart';
import 'package:verbose_share_world/generated/l10n.dart';
import 'package:verbose_share_world/locale/language_cubit.dart';
import 'package:verbose_share_world/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit()..getCurrentLanguage(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              CountryLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: LoginNavigator(),
            routes: PageRoutes().routes(),
          );
        },
      ),
    );
  }
}
