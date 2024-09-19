import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/constants.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/config/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/environment/environment.dart';
import 'package:my_app/providers.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';
import 'package:my_app/repository/auth/auth_http_repository.dart';
import 'package:my_app/repository/brand/brand_http_repository.dart';
import 'package:my_app/repository/brand/brand_repository.dart';
import 'package:my_app/repository/category/category_api_repository.dart';
import 'package:my_app/repository/category/category_http_repository.dart';
import 'package:my_app/repository/product/product_http_repository.dart';
import 'package:my_app/repository/product/product_repository.dart';
import 'package:my_app/repository/wishlist/wishlist_api_repository.dart';
import 'package:my_app/repository/wishlist/wishlist_http_repository.dart';
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
        return Providers(
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
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryColor,
              primaryColor: AppColors.buttonColor,
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
  getIt.registerLazySingleton<CategoryApiRepository>(
      () => CategoryHttpRepository());
  getIt.registerLazySingleton<ProductApiRepository>(
      () => ProductHttpRepository());
  getIt.registerLazySingleton<BrandApiRepository>(() => BrandHttpRepository());
  getIt.registerLazySingleton<WishListApiRepository>(
      () => WishlistHttpRepository());
}
