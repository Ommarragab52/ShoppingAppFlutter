import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/core/networking/api_service.dart';
import 'package:flutter_ecommerce_app/core/networking/dio_factory.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/repository/addresses_repository.dart';
import 'package:flutter_ecommerce_app/features/addresses/logic/addresses_cubit.dart';
import 'package:flutter_ecommerce_app/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:flutter_ecommerce_app/features/cart/data/repo/cart_repository.dart';
import 'package:flutter_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:flutter_ecommerce_app/features/category/data/repository/category_repository.dart';
import 'package:flutter_ecommerce_app/features/category/logic/category_cubit.dart';
import 'package:flutter_ecommerce_app/features/favorites/data/repos/favorites_repository.dart';
import 'package:flutter_ecommerce_app/features/favorites/logic/favorites_cubit.dart';
import 'package:flutter_ecommerce_app/features/home/data/repository/home_repository.dart';
import 'package:flutter_ecommerce_app/features/home/logic/home_cubit.dart';
import 'package:flutter_ecommerce_app/features/home_layout/logic/cubit/home_layout_cubit.dart';
import 'package:flutter_ecommerce_app/features/notifications/data/repo/notifications_repo.dart';
import 'package:flutter_ecommerce_app/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/data/repos/product_details_repository.dart';
import 'package:flutter_ecommerce_app/features/products/data/repos/products_repository.dart';
import 'package:flutter_ecommerce_app/features/products/data/repos/products_search_repository.dart';
import 'package:flutter_ecommerce_app/features/products/logic/product_details_cubit/product_details_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/products_search_cubit/products_search_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_cubit.dart';
import 'package:flutter_ecommerce_app/features/profile/data/repository/profile_repository.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;

  static Future setUpGetIt() async {
    // Get dio instance
    Dio dio = DioFactory.getDio();

    // Inject Api Service
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

    //Auth
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt()));
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

    //home layout
    getIt.registerLazySingleton<HomeLayoutCubit>(() => HomeLayoutCubit());

    //home
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt()));
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

    //category
    getIt.registerLazySingleton<CategoryRepository>(
        () => CategoryRepository(getIt()));
    getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt()));

    // products
    getIt.registerLazySingleton<ProductsRepository>(
        () => ProductsRepository(getIt()));
    getIt.registerLazySingleton<ProductsCubit>(() => ProductsCubit(getIt()));

    // product details
    getIt.registerLazySingleton<ProductDetailsRepository>(
        () => ProductDetailsRepository(getIt()));
    getIt.registerFactory<ProductDetailsCubit>(
        () => ProductDetailsCubit(getIt()));
    // products search
    getIt.registerLazySingleton<ProductsSearchRepository>(
        () => ProductsSearchRepository(getIt()));
    getIt.registerFactory<ProductsSearchCubit>(
        () => ProductsSearchCubit(getIt()));

    // favorites
    getIt.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepository(getIt()),
    );
    getIt.registerLazySingleton<FavoritesCubit>(
      () => FavoritesCubit(getIt()),
    );
    // notifications
    getIt.registerLazySingleton<NotificationsRepo>(
        () => NotificationsRepo(getIt()));
    getIt.registerFactory<NotificationsCubit>(
      () => NotificationsCubit(getIt()),
    );
    // Cart
    getIt.registerLazySingleton<CartRepository>(() => CartRepository(getIt()));
    getIt.registerLazySingleton<CartCubit>(
      () => CartCubit(getIt()),
    );
    // Profile
    getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepository(getIt()));
    getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

    // Addresses
    getIt.registerLazySingleton<AddressesRepository>(
        () => AddressesRepository(getIt()));
    getIt.registerLazySingleton<AddressesCubit>(() => AddressesCubit(getIt()));
  }

  static HomeLayoutCubit get homeLayoutCubit => getIt<HomeLayoutCubit>();

  static HomeCubit get homeCubit => getIt<HomeCubit>();

  static CategoryCubit get categoryCubit => getIt<CategoryCubit>();

  static ProductsCubit get productsCubit => getIt<ProductsCubit>();

  static ProductDetailsCubit get productDetailsCubit =>
      getIt<ProductDetailsCubit>();

  static AuthCubit get authCubit => getIt<AuthCubit>();

  static ProductsSearchCubit get productsSearchCubit =>
      getIt<ProductsSearchCubit>();

  static FavoritesCubit get favoritesCubit => getIt<FavoritesCubit>();

  static NotificationsCubit get notificationsCubit =>
      getIt<NotificationsCubit>();

  static CartCubit get cartCubit => getIt<CartCubit>();

  static ProfileCubit get profileCubit => getIt<ProfileCubit>();

  static AddressesCubit get addressesCubit => getIt<AddressesCubit>();
}
