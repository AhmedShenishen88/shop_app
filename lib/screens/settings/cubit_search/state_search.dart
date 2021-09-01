import 'package:newshop/moudels/search_model/searchmod.dart';

abstract class SearchCubitState {}

class InitialStateSearch extends SearchCubitState {}

class LoadingStateSearch extends SearchCubitState {}

class SuccessStateSearch extends SearchCubitState {}

class ErrorStateSearch extends SearchCubitState {}
