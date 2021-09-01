import 'package:newshop/moudels/login_model/ogin_mod.dart';

abstract class CubitShopStateRegister {}

class CubitShopInitializeRegister extends CubitShopStateRegister {}

class CubitStatePostDataLoadingRegister extends CubitShopStateRegister {}

class CubitStatePostDataSuccessRegister extends CubitShopStateRegister {
  final ShopLoginModel loginModel;

  CubitStatePostDataSuccessRegister(this.loginModel);
}

class CubitStatePostDataErrorRegister extends CubitShopStateRegister {
  final error;
  CubitStatePostDataErrorRegister(this.error);
}

class ChangeSeeVisibilityPasswordStateRegister extends CubitShopStateRegister {}
