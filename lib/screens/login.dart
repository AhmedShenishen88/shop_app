import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/Cubits/Cubit/cubit_shop.dart';
import 'package:newshop/Cubits/Cubit/cubit_state.dart';
import 'package:newshop/Network/shearedpref/shared.dart';
import 'package:newshop/screens/layout_screens/shop_layout1.dart';
import 'package:newshop/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textEmailControl = TextEditingController();
  var textPasswordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitShop(),
        child: BlocConsumer<CubitShop, CubitShopState>(
          listener: (context, state) {
            if (state is CubitStatePostDataSuccess) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);

                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data.token)
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopLayout1()),
                      (route) => false);
                });
              } else {
                showToast(
                    massage: state.loginModel.message,
                    state: lockToastStats.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Don't Forget your Email And Password ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                                controlText: textEmailControl,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Email Must Not Empty';
                                  }
                                  return null;
                                },
                                textLabel: 'Email',
                                prefix: Icons.email),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                                controlText: textPasswordControl,
                                isPassword: CubitShop.get(context).isPassword,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {
                                    CubitShop.get(context).userLogin(
                                        email: textEmailControl.text,
                                        password: textPasswordControl.text);
                                  }
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Password Must Not Empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                suffix: CubitShop.get(context).suffix,
                                suffixPressed: () {
                                  CubitShop.get(context)
                                      .changeSeeVisibilityPassword();
                                },
                                textLabel: 'Password'),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! CubitStatePostDataLoading,
                              builder: (context) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      CubitShop.get(context).userLogin(
                                          email: textEmailControl.text,
                                          password: textPasswordControl.text);
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Don't have Email ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen()));
                                    },
                                    child: Text('Register'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue)))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
