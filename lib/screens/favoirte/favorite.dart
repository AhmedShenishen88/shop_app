import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShopScreenAll, CubitStatesBottom>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => favoriteBuilder(
                  CubitShopScreenAll.get(context)
                      .getFavoritesModel
                      .data
                      .data[index],
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: CubitShopScreenAll.get(context)
                  .getFavoritesModel
                  .data
                  .data
                  .length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget favoriteBuilder(model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product.image}'),
                    height: 150.0,
                    width: 150,
                  ),
                  if (model.product.discount != 0)
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
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price.round()}',
                          style: TextStyle(color: Colors.blue, fontSize: 12.0),
                        ),
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice.round()}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              CubitShopScreenAll.get(context)
                                  .changeFavorites(model.product.id);
                              print(model.product.id);
                            },
                            icon: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: CubitShopScreenAll.get(context)
                                        .favorite[model.product.id]
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
        ),
      );
}
