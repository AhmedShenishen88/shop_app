import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';
import 'package:newshop/screens/search/searc.dart';

class ShopLayout1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShopScreenAll, CubitStatesBottom>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CubitShopScreenAll.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.screensBott[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeScreenBoot(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
