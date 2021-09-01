import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/constants.dart';
import 'package:newshop/Cubits/Cubit/cubit_observe.dart';
import 'package:newshop/Network/dio_pages/dio_rules.dart';
import 'package:newshop/onborder/borderpage.dart';
import 'package:newshop/screens/layout_screens/shop_layout1.dart';
import 'package:newshop/screens/login.dart';
import 'Cubits/cubit_bottom/cubit_screen.dart';
import 'Network/shearedpref/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget widget;
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout1();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(Material(
    // onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class Material extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;
  Material({this.onBoarding, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CubitShopScreenAll()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getProfileData()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0.0,
                backwardsCompatibility: false,
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              elevation: 20,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            )),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ), // onBoarding ? LoginScreen() : OnBoardingScreen()
    );
  }
}
