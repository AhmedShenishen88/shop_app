import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/constants.dart';
import 'package:newshop/Network/dio_pages/dio_rules.dart';
import 'package:newshop/Network/end_points.dart';
import 'package:newshop/moudels/search_model/searchmod.dart';
import 'package:newshop/screens/settings/cubit_search/state_search.dart';

class CubitSearch extends Cubit<SearchCubitState> {
  CubitSearch() : super(InitialStateSearch());

  static CubitSearch get(context) => BlocProvider.of(context);

  SearchGetModel searchModel;
  void getSearchData(String text) {
    emit(LoadingStateSearch());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchGetModel.fromJson(value.data);

      emit(SuccessStateSearch());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorStateSearch());
    });
  }
}
