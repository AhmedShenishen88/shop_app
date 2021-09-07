import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newshop/Cubits/cubit_bottom/cubit_screen.dart';
import 'package:newshop/moudels/categore_model/categories_model.dart';

Widget defaultFormField({
  @required TextEditingController controlText,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  Function suffixPressed,
  @required Function validate,
  @required String textLabel,
  @required IconData prefix,
  IconData suffix,
  bool isClickable = true,
}) =>
    TextFormField(
      keyboardType: type,
      validator: validate,
      enabled: isClickable,
      controller: controlText,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
          //make sure use prefixIcon not prefix بس
          prefixIcon: Icon(prefix),
          border: OutlineInputBorder(),
          suffix: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed,
                )
              : null,
          labelText: textLabel),
    );

void showToast({@required String massage, @required lockToastStats state}) =>
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum lockToastStats { SUCCESS, ERROR, WARNING }

Color chooseToastColor(lockToastStats state) {
  Color color;
  switch (state) {
    case lockToastStats.SUCCESS:
      color = Colors.green;
      break;
    case lockToastStats.ERROR:
      color = Colors.red;
      break;
    case lockToastStats.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget myDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1.0,
    );
Widget anShapeToCategories(DataOfDataModel dataModel) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12.0)]),
        child: Card(
          elevation: 10.0,
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
        ),
      ),
    );

Widget listProductBuilder(model, context, {bool isOldPrice = true}) => Padding(
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
                  image: NetworkImage(model.image),
                  height: 150.0,
                  width: 150,
                ),
                if (model.discount != 0 && isOldPrice)
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
                    model.name,
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
                        '${model.price}',
                        style: TextStyle(color: Colors.blue, fontSize: 12.0),
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
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
                                          .favorite[model.id] ==
                                      true
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
