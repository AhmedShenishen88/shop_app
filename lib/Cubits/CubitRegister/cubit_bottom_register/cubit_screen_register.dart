import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newshop/Cubits/Cubit/cubit_state.dart';
import 'package:newshop/Cubits/CubitRegister/cubit_bottom_register/states_register.dart';
import 'package:newshop/Network/dio_pages/dio_rules.dart';
import 'package:newshop/Network/end_points.dart';
import 'package:newshop/moudels/login_model/ogin_mod.dart';

class CubitShopRegister extends Cubit<CubitShopStateRegister> {
  CubitShopRegister() : super(CubitShopInitializeRegister());

  ShopLoginModel loginModel;

  static CubitShopRegister get(context) => BlocProvider.of(context);

  void userLogin({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(CubitStatePostDataLoadingRegister());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(CubitStatePostDataSuccessRegister(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(CubitStatePostDataErrorRegister(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeSeeVisibilityPassword() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSeeVisibilityPasswordStateRegister());
  }
}
