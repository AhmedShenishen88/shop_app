import 'package:newshop/moudels/favorites/favoritebottommodel.dart';
import 'package:newshop/moudels/login_model/ogin_mod.dart';

abstract class CubitStatesBottom {}

class ShopInitializeStateBottom extends CubitStatesBottom {}

class ShopChangeBottomNav extends CubitStatesBottom {}

class ShopLoadingHome extends CubitStatesBottom {}

class ShopSuccessHome extends CubitStatesBottom {}

class ShopErrorHome extends CubitStatesBottom {}

class ShopSuccessCategories extends CubitStatesBottom {}

class ShopErrorCategories extends CubitStatesBottom {}

class ShopLoadingFavorites extends CubitStatesBottom {}

class ShopSuccessFavorites extends CubitStatesBottom {
  final FavoritesModel model;

  ShopSuccessFavorites(this.model);
}

class ShopErrorFavorites extends CubitStatesBottom {}

class ShopSuccessGetFavoritesData extends CubitStatesBottom {}

class ShopLoadingGetFavoritesState extends CubitStatesBottom {}

class ShopErrorGetFavoritesData extends CubitStatesBottom {}

class ShopSuccessGetProfileData extends CubitStatesBottom {
  final ShopLoginModel loginModel;

  ShopSuccessGetProfileData(this.loginModel);
}

class ShopLoadingGetProfileState extends CubitStatesBottom {}

class ShopErrorGetProfileData extends CubitStatesBottom {}

class ShopSuccessUpDateData extends CubitStatesBottom {
  final ShopLoginModel loginModel;

  ShopSuccessUpDateData(this.loginModel);
}

class ShopLoadingUpDateState extends CubitStatesBottom {}

class ShopErrorUpDateData extends CubitStatesBottom {}
