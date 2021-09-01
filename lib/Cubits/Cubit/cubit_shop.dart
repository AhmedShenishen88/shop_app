import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newshop/Cubits/Cubit/cubit_state.dart';
import 'package:newshop/Network/dio_pages/dio_rules.dart';
import 'package:newshop/Network/end_points.dart';
import 'package:newshop/moudels/login_model/ogin_mod.dart';

class CubitShop extends Cubit<CubitShopState> {
  CubitShop() : super(CubitShopInitialize());

  ShopLoginModel loginModel;

  static CubitShop get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(CubitStatePostDataLoading());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(CubitStatePostDataSuccess(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(CubitStatePostDataError(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeSeeVisibilityPassword() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSeeVisibilityPasswordState());
  }
}
