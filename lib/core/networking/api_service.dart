import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/core/networking/api_constants.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/change_password_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/change_password_response.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/login_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/login_response/login_response.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/register_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/register_response/register_response.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/add_delete_cart/add_delete_cart_request.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/add_delete_cart/add_delete_cart_response.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/cart_response/cart_response.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/update_cart/update_cart_request.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/update_cart/update_cart_response.dart';
import 'package:flutter_ecommerce_app/features/category/data/models/categories/category_response.dart';
import 'package:flutter_ecommerce_app/features/favorites/data/models/favorite_add_delete/favorite_add_delete_request.dart';
import 'package:flutter_ecommerce_app/features/favorites/data/models/favorite_add_delete/favorite_add_delete_response.dart';
import 'package:flutter_ecommerce_app/features/favorites/data/models/favorite_delete_response/favorite_delete_response.dart';
import 'package:flutter_ecommerce_app/features/favorites/data/models/favorites_response/favorites_response.dart';
import 'package:flutter_ecommerce_app/features/home/data/models/home_response/home_response.dart';
import 'package:flutter_ecommerce_app/features/notifications/data/models/notifications_response/notifications_response.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/product_details_response/product_details_response.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/product_response/products_response.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/products_search_models/products_search_request.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/products_search_models/products_search_response.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/profile_response.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/update_profile_request.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Login
  @POST(ApiConstants.login)
  Future<LoginResponse> signIn(@Body() LoginRequest loginRequest);

  // Register
  @POST(ApiConstants.register)
  Future<RegisterResponse> signUp(@Body() RegisterRequest registerRequest);

  // Home
  @GET(ApiConstants.home)
  Future<HomeResponse> getHomeData();

  // Categories
  @GET(ApiConstants.categories)
  Future<CategoryResponse> getCategories(
    @Query('page') int? page,
  );

  // get Products
  @GET(ApiConstants.products)
  Future<ProductsResponse> getProducts(
    @Query('page') int? page,
    @Query('category_id') int? categoryId,
  );

  // get Product by id
  @GET('${ApiConstants.products}/{productId}')
  Future<ProductDetailsResponse> getProductById(
    @Path('productId') int productId,
  );

  // get Products by Search
  @POST(ApiConstants.productsSearch)
  Future<ProductsSearchResponse> getProductsByName(
    @Body() ProductsSearchRequest productsSearchRequest,
  );

  // Get Favorites
  @GET(ApiConstants.favorites)
  Future<FavoritesResponse> getFavorites();

  // Add Delete Favorite
  @POST(ApiConstants.favorites)
  Future<FavoriteAddDeleteResponse> addDeleteFavoriteByProductId(
    @Body() FavoriteAddDeleteRequest favoriteAddDeleteRequest,
  );

  // Delete Favorite
  @DELETE('${ApiConstants.favorites}/{favoriteId}')
  Future<FavoriteDeleteResponse> deleteFavoriteByFavoriteId(
    @Path('favoriteId') int favoriteId,
  );

  // Get Notifications
  @GET(ApiConstants.notifications)
  Future<NotificationsResponse> getNotifications();

  // Get Carts
  @GET(ApiConstants.carts)
  Future<CartResponse> getCarts();

  // Add Delete Carts
  @POST(ApiConstants.carts)
  Future<AddDeleteCartResponse> addDeleteCartByProductId(
    @Body() AddDeleteCartRequest addDeleteCartRequest,
  );

  // Update Cart
  @PUT('${ApiConstants.carts}/{cartId}')
  Future<UpdateCartResponse> updateCartByCartId(
    @Path('cartId') int cartId,
    @Body() UpdateCartRequest updateCartRequest,
  );

  // Get Profile
  @GET(ApiConstants.profile)
  Future<ProfileResponse> getProfile();

  // Update Profile
  @PUT(ApiConstants.updateProfile)
  Future<ProfileResponse> updateProfile(
    @Body() UpdateProfileRequest updateProfileRequest,
  );

  // Change Password
  @POST(ApiConstants.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest changePasswordRequest,
  );
}
