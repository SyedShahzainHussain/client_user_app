import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/constants.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/config/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/environment/environment.dart';
import 'package:my_app/bloc/change_languages/change_language_bloc.dart';
import 'package:my_app/providers.dart';
import 'package:my_app/repository/address/address_http_repository.dart';
import 'package:my_app/repository/address/address_repository.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';
import 'package:my_app/repository/auth/auth_http_repository.dart';
import 'package:my_app/repository/brand/brand_http_repository.dart';
import 'package:my_app/repository/brand/brand_repository.dart';
import 'package:my_app/repository/category/category_api_repository.dart';
import 'package:my_app/repository/category/category_http_repository.dart';
import 'package:my_app/repository/google_place_repository/google_place_api_repository.dart';
import 'package:my_app/repository/google_place_repository/google_place_http_repository.dart';
import 'package:my_app/repository/order/order_http_repository.dart';
import 'package:my_app/repository/product/product_http_repository.dart';
import 'package:my_app/repository/product/product_repository.dart';
import 'package:my_app/repository/rating/rating_api_repository.dart';
import 'package:my_app/repository/rating/rating_http_repository.dart';
import 'package:my_app/repository/restaurant/restaurant_http_repository.dart';
import 'package:my_app/repository/restaurant/restaurant_repository.dart';
import 'package:my_app/repository/side_topping/side_topping_http_repository.dart';
import 'package:my_app/repository/side_topping/side_topping_repository.dart';
import 'package:my_app/repository/wishlist/wishlist_api_repository.dart';
import 'package:my_app/repository/wishlist/wishlist_http_repository.dart';

import 'repository/order/order_api_repository.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51Q5KJwFZrkxj3I7BTUqIczunxa6jOSZ2InlMq9W6A4C6ZHQZHijvBX3lvjUgLyVwBUOQ0YA60HzzeCDGKMaXfNIp00Rc0FKvlp";
  try {
    WidgetsFlutterBinding.ensureInitialized();
    serviceLocator();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    const String enviroment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: Environment.prod,
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
          child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Kebabberia',
                supportedLocales: const [
                  Locale('en', 'US'), // English (United States)
                  Locale('it', 'IT') // Italian (Italy)
                ],
                locale: state.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.primaryColor,
                  primaryColor: AppColors.buttonColor,
                  indicatorColor: AppColors.buttonColor,
                  textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: AppColors.buttonColor, //<-- SEE HERE
                      selectionColor: AppColors.buttonColor,
                      selectionHandleColor: AppColors.buttonColor),
                  textTheme: GoogleFonts.acmeTextTheme(
                      Typography.englishLike2018.apply(
                    fontSizeFactor: 1.sp,
                  )),
                ),
                onGenerateRoute: Routes.generateRoute,
                initialRoute: RouteName.splashScreenName,
              );
            },
          ),
        );
      },
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<AuthApiRepository>(() => AuthHttpRepository());
  getIt.registerLazySingleton<BrandApiRepository>(() => BrandHttpRepository());
  getIt.registerLazySingleton<CategoryApiRepository>(
      () => CategoryHttpRepository());
  getIt.registerLazySingleton<ProductApiRepository>(
      () => ProductHttpRepository());
  getIt.registerLazySingleton<WishListApiRepository>(
      () => WishlistHttpRepository());
  getIt.registerLazySingleton<SideToppingApiRepository>(
      () => SideToppingHttpRepository());
  getIt.registerLazySingleton<OrderApiRepository>(() => OrderHttpRepository());
  getIt.registerLazySingleton<GooglePlaceApiHttpRepository>(
      () => GooglePlaceApiRepository());
  getIt.registerLazySingleton<RestaurantHttpRepository>(
      () => RestaurantRepository());
  getIt.registerLazySingleton<AddressRepository>(() => AddressHttpRepository());
  getIt
      .registerLazySingleton<RatingApiRepository>(() => RatingHttpRepository());
}
