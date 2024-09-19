import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/check_authentication/check_authentiaction_bloc.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/social_login_bloc/social_bloc_bloc.dart';
import 'package:my_app/bloc/brand/brand_bloc.dart';
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
        create: (context) => CategoryBloc(categoryApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => ProductBloc(productApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => BrandBloc(brandApiRepository: getIt()),
      ),
      BlocProvider(
        create: (context) => WishlistBloc(wishListApiRepository: getIt()),
      ),
    ], child: child);
  }
}
