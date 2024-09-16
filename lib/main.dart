import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/bloc/auth/check_authentication/check_authentiaction_bloc.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/social_login_bloc/social_bloc_bloc.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/constants.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/config/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/environment/environment.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';
import 'package:my_app/repository/auth/auth_http_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    serviceLocator();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    const String enviroment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: Environment.dev,
    );

    Environment().initConfig(enviroment);

    runApp(const MyApp());
  } catch (e) {
    rethrow;
  }
}

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CheckAuthentiactionBloc(),
            ),
            BlocProvider(
              create: (context) => ForgotBloc(authApiRepository: getIt()),
            ),
            BlocProvider(
              create: (context) => SocialBlocBloc(authApiRepository: getIt()),
            ),
          ],
          child: MaterialApp(
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
          ),
        );
      },
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<AuthApiRepository>(() => AuthHttpRepository());
}
