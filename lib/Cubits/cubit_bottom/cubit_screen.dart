import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/constants.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';
import 'package:newshop/Network/dio_pages/dio_rules.dart';
import 'package:newshop/Network/end_points.dart';
import 'package:newshop/moudels/categore_model/categories_model.dart';
import 'package:newshop/moudels/favorites/favoritebottommodel.dart';
import 'package:newshop/moudels/favorites/favoritemodel.dart';
import 'package:newshop/moudels/home_model/model_of_home.dart';
import 'package:newshop/moudels/login_model/ogin_mod.dart';
import 'package:newshop/screens/categories/categor.dart';
import 'package:newshop/screens/favoirte/favorite.dart';
import 'package:newshop/screens/product/product.dart';
import 'package:newshop/screens/settings/setting.dart';

class CubitShopScreenAll extends Cubit<CubitStatesBottom> {
  CubitShopScreenAll() : super(ShopInitializeStateBottom());

  static CubitShopScreenAll get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screensBott = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeScreenBoot(index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  HomeModel homeModel;
  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHome());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.data.banner.toString());
      // print(homeModel.toString());

      homeModel.data.product.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });
      print(favorite);

      emit(ShopSuccessHome());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHome());
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      printFullText(categoriesModel.data.data.toString());
      print(categoriesModel.toString());
      emit(ShopSuccessCategories());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategories());
    });
  }

  FavoritesModel favoritesModel;

  void changeFavorites(int productId) {
    favorite[productId] = !favorite[productId];
    emit(ShopLoadingFavorites());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      if (!favoritesModel.status) {
        favorite[productId] = !favorite[productId];
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessFavorites(favoritesModel));
    }).catchError((error) {
      favorite[productId] = !favorite[productId];
      emit(ShopErrorFavorites());
    });
  }

  FavoritesGetModel getFavoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      getFavoritesModel = FavoritesGetModel.fromJson(value.data);
      printFullText(getFavoritesModel.toString());
      emit(ShopSuccessGetFavoritesData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesData());
    });
  }

  ShopLoginModel getProfileSetting;
  void getProfileData() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      getProfileSetting = ShopLoginModel.fromJson(value.data);
      printFullText(getProfileSetting.data.name);
      emit(ShopSuccessGetProfileData(getProfileSetting));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileData());
    });
  }

  void upDateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpDateState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      getProfileSetting = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpDateData(getProfileSetting));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpDateData());
    });
  }
}
