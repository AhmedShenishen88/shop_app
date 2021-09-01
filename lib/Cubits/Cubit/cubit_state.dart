import 'package:newshop/moudels/login_model/ogin_mod.dart';

abstract class CubitShopState {}

class CubitShopInitialize extends CubitShopState {}

class CubitStatePostDataLoading extends CubitShopState {}

class CubitStatePostDataSuccess extends CubitShopState {
  final ShopLoginModel loginModel;

  CubitStatePostDataSuccess(this.loginModel);
}

class CubitStatePostDataError extends CubitShopState {
  final error;
  CubitStatePostDataError(this.error);
}

class ChangeSeeVisibilityPasswordState extends CubitShopState {}
