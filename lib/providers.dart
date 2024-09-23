import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/check_authentication/check_authentiaction_bloc.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/bloc/auth/social_login_bloc/social_bloc_bloc.dart';
import 'package:my_app/bloc/brand/brand_bloc.dart';
import 'package:my_app/bloc/cart/cart_bloc.dart';
import 'package:my_app/bloc/category/category_bloc.dart';
import 'package:my_app/bloc/products/product_bloc.dart';
import 'package:my_app/bloc/wishlist/wishlist_bloc.dart';
import 'package:my_app/main.dart';

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
        create: (context) => SocialBlocBloc(authApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(categoryApiRepository: getIt())..add(FetchCategory()),
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
        create: (context) =>
            ProfileBloc(apiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) =>
            CartBloc(),
      ),
    ], child: child);
  }
}
