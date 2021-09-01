import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';
import 'package:newshop/moudels/categore_model/categories_model.dart';
import 'package:newshop/moudels/home_model/model_of_home.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShopScreenAll, CubitStatesBottom>(
      listener: (context, state) {
        if (state is ShopSuccessFavorites) {
          if (!state.model.status) {
            showToast(
                massage: state.model.message, state: lockToastStats.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CubitShopScreenAll.get(context).homeModel != null &&
              CubitShopScreenAll.get(context).categoriesModel != null,
          builder: (context) => productScreenHome(
              CubitShopScreenAll.get(context).homeModel,
              CubitShopScreenAll.get(context).categoriesModel,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productScreenHome(HomeModel model, CategoriesModel catMode, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banner
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            categoriesItemBuilder(catMode.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: catMode.data.data.length),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.51,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: List.generate(
                    model.data.product.length,
                    (index) =>
                        productItemBuilder(model.data.product[index], context)),
              ),
            )
          ],
        ),
      );

  Widget categoriesItemBuilder(DataOfDataModel catModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${catModel.image}'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
              width: 100.0,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                catModel.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      );

  Widget productItemBuilder(ProductModelData model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(color: Colors.blue, fontSize: 12.0),
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            CubitShopScreenAll.get(context)
                                .changeFavorites(model.id);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: CubitShopScreenAll.get(context)
                                      .favorite[model.id]
                                  ? Colors.blue
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
