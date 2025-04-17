import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/dpendency_injection.dart';
import 'package:flutter_ecommerce_app/core/helpers/shared_pref_helper.dart';
import 'package:flutter_ecommerce_app/core/networking/dio_factory.dart';
import 'package:flutter_ecommerce_app/core/utils/app_constants.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extenstions.dart';

bool isLoggedInUser = false;
bool isOpenAppForFirstTime = false;

Future showOnBoarding() async {
  bool? isFirstTime = await SharedPref.getBool(SharedPrefKeys.openAppFirstTime);
  if (isFirstTime == null) {
    isOpenAppForFirstTime = true;
  } else {
    isOpenAppForFirstTime = false;
  }
}

Future isUserLoggedIn() async {
  String token = await SharedPref.getSecuredString(SharedPrefKeys.userToken);
  if (!token.isNullOrEmpty()) {
    DioFactory.addTokenToHeader(token);
    isLoggedInUser = true;
    debugPrint('User Logged In!');
  } else {
    isLoggedInUser = false;
    debugPrint('User Not Logged In!');
  }
}

String initialRoute() {
  if (isOpenAppForFirstTime) {
    return Routes.onBoardingScreen;
  } else if (isLoggedInUser) {
    return Routes.homeLayoutScreen;
  } else {
    return Routes.loginScreen;
  }
}

Widget buildBlocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ServiceLocator.homeLayoutCubit,
      ),
      BlocProvider(
        create: (context) => ServiceLocator.homeCubit..getHomeData(),
      ),
      BlocProvider(
        create: (context) => ServiceLocator.productsCubit..getProducts(),
      ),
      BlocProvider(
        create: (context) => ServiceLocator.categoryCubit..getCategories(),
      ),
      BlocProvider(
        create: (context) => ServiceLocator.favoritesCubit..fetchFavorites(),
      ),
      BlocProvider(
        create: (context) =>
            ServiceLocator.notificationsCubit..getNotifications(),
      ),
      BlocProvider(
        create: (context) => ServiceLocator.cartCubit..getCarts(),
      ),
      BlocProvider(
        create: (context) => ServiceLocator.profileCubit..getLoginUser(),
      )
    ],
    child: child,
  );
}
