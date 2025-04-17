import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:flutter_ecommerce_app/features/auth/ui/login_screen.dart';
import 'package:flutter_ecommerce_app/features/auth/ui/register_screen.dart';
import 'package:flutter_ecommerce_app/features/category/data/models/categories/category_response.dart';
import 'package:flutter_ecommerce_app/features/favorites/ui/favorites_screen.dart';
import 'package:flutter_ecommerce_app/features/home_layout/ui/home_layout.dart';
import 'package:flutter_ecommerce_app/features/notifications/ui/notifications_screen.dart';
import 'package:flutter_ecommerce_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter_ecommerce_app/features/products/ui/product_details_screen/product_details_screen.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/products_screen.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_search_screen/products_search_screen.dart';
import 'package:flutter_ecommerce_app/features/profile/ui/edit_profile_screen.dart';
import 'package:flutter_ecommerce_app/features/profile/ui/profile_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => ServiceLocator.getIt<AuthCubit>(),
                child: const LoginScreen()));

      case Routes.registerScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => ServiceLocator.getIt<AuthCubit>(),
                child: const RegisterScreen()));

      case Routes.homeLayoutScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeLayout(),
        );

      case Routes.productsScreen:
        CategoryModel? categoryModel;
        if (settings.arguments != null) {
          final arguments = settings.arguments as Map<String, dynamic>;
          categoryModel = arguments['categoryModel'] as CategoryModel;
        }
        return MaterialPageRoute(
          builder: (context) => ProductsScreen(categoryModel: categoryModel),
        );

      case Routes.productDetailsScreen:
        final productId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ServiceLocator.productDetailsCubit..getProduct(productId),
            child: const ProductDetailsScreen(),
          ),
        );

      case Routes.productsSearchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ServiceLocator.productsSearchCubit,
            child: const ProductsSearchScreen(),
          ),
        );

      case Routes.favoritesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FavoritesScreen());

      case Routes.notificationsScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NotificationsScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileScreen(),
        );
      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      default:
        return null;
    }
  }
}
