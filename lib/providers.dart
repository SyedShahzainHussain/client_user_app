import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/address/address_bloc.dart';
import 'package:my_app/bloc/auth/check_authentication/check_authentiaction_bloc.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/password/password_bloc.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/bloc/brand/brand_bloc.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/bloc/category/category_bloc.dart';
import 'package:my_app/bloc/google_place_api/google_place_api_bloc.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/bloc/rating/ratng_bloc.dart';
import 'package:my_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:my_app/bloc/side_topping/side_topping_event.dart';
import 'package:my_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:my_app/bloc/change_languages/change_language_bloc.dart';
import 'package:my_app/main.dart';

import 'bloc/order/order_bloc.dart';
import 'bloc/side_topping/side_topping_bloc.dart';

class Providers extends StatelessWidget {
  final Widget child;
  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CheckAuthentiactionBloc(),
      ),
      BlocProvider(
        create: (context) => ForgotBloc(authApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) =>
            CategoryBloc(categoryApiRepository: getIt())..add(FetchCategory()),
      ),
      BlocProvider(
        create: (context) => ProductBloc(productApiRepository: getIt())
          ..add(const GetAllProducts("All")),
      ),
      BlocProvider(
        create: (context) =>
            BrandBloc(brandApiRepository: getIt())..add(GetAllBrand()),
      ),
      BlocProvider(
        create: (context) =>
            WishlistBloc(wishListApiRepository: getIt())..add(GetWishlist()),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(apiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => CartBloc(),
      ),
      BlocProvider(
        create: (context) => SideToppingBloc(sideToppingApiRepository: getIt())
          ..add(FetchAllSideTopping()),
      ),
      BlocProvider(
        create: (context) => OrderBloc(orderApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => ChangeLanguageBloc()..add(LoadSavedLanguage()),
      ),
      BlocProvider(
        create: (context) =>
            GooglePlaceApiBloc(googlePlaceApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => RestaurantBloc(restaurantRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => AddressBloc(addressHttpRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => ChangePasswordBloc(authHttpRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => RatingBloc(ratingApiRepository: getIt()),
      ),
    ], child: child);
  }
}
