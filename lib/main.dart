import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/constants.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/config/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    runApp(const MyApp());
  } catch (e) {
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(Constants.width, Constants.height),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kebabberia',
          supportedLocales: const [
            Locale('en'), // English
            Locale('it'), // Italy
          ],
          locale: const Locale("it"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
            textTheme:
                GoogleFonts.acmeTextTheme(Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
            )),
          ),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: RouteName.splashScreenName,
        );
      },
    );
  }
}
