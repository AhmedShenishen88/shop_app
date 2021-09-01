import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/Cubits/cubit_bottom/states.dart';
import 'package:newshop/moudels/categore_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShopScreenAll, CubitStatesBottom>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoriesBuilderScreen(
                CubitShopScreenAll.get(context)
                    .categoriesModel
                    .data
                    .data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: CubitShopScreenAll.get(context)
                .categoriesModel
                .data
                .data
                .length);
      },
    );
  }

  Widget categoriesBuilderScreen(DataOfDataModel dataModel) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${dataModel.image}'),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              dataModel.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
